#!/usr/bin/env python3
"""Generate or verify MANIFEST_SHA256.txt for NRMenu."""

from __future__ import annotations

import argparse
import hashlib
import os
import subprocess
import sys
from pathlib import Path

MANIFEST = "MANIFEST_SHA256.txt"
EXCLUDED_DIRS = {
    ".git",
    "work",
    "backups",
    "export",
    "repo-update-backups",
    "__pycache__",
    ".venv",
    "venv",
}
EXCLUDED_FILES = {
    MANIFEST,
}
EXCLUDED_SUFFIXES = {
    ".pyc",
}


def repository_root() -> Path:
    return Path(__file__).resolve().parents[1]


def git_files(root: Path) -> list[Path] | None:
    if not (root / ".git").exists():
        return None

    try:
        result = subprocess.run(
            ["git", "-C", str(root), "ls-files", "-z"],
            check=True,
            capture_output=True,
        )
    except (FileNotFoundError, subprocess.CalledProcessError):
        return None

    items = []
    for raw in result.stdout.split(b"\0"):
        if not raw:
            continue
        path = root / os.fsdecode(raw)
        if path.is_file():
            items.append(path)
    return items


def walk_files(root: Path) -> list[Path]:
    items: list[Path] = []
    for path in root.rglob("*"):
        if not path.is_file():
            continue

        relative = path.relative_to(root)
        if any(part in EXCLUDED_DIRS for part in relative.parts):
            continue
        if relative.as_posix() in EXCLUDED_FILES:
            continue
        if path.suffix.lower() in EXCLUDED_SUFFIXES:
            continue

        # Local build output is excluded except for the tracked placeholder.
        if relative.parts and relative.parts[0] == "dist" and relative.as_posix() != "dist/.gitkeep":
            continue

        items.append(path)
    return items


def included_files(root: Path) -> list[Path]:
    return sorted(
        walk_files(root),
        key=lambda p: p.relative_to(root).as_posix().lower(),
    )


def digest(path: Path) -> str:
    hasher = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            hasher.update(chunk)
    return hasher.hexdigest().upper()


def create_lines(root: Path) -> list[str]:
    return [
        f"{digest(path)}  {path.relative_to(root).as_posix()}"
        for path in included_files(root)
    ]


def update(root: Path) -> int:
    lines = create_lines(root)
    target = root / MANIFEST
    target.write_text("\n".join(lines) + "\n", encoding="ascii", newline="\n")
    print(f"Manifest regenerated: {target}")
    print(f"Files recorded: {len(lines)}")
    return 0


def verify(root: Path) -> int:
    target = root / MANIFEST
    if not target.exists():
        print(f"ERROR: missing {target}", file=sys.stderr)
        return 1

    expected: dict[str, str] = {}
    errors: list[str] = []

    for number, line in enumerate(target.read_text(encoding="ascii").splitlines(), start=1):
        if not line.strip():
            continue
        try:
            hash_value, relative = line.split("  ", 1)
        except ValueError:
            errors.append(f"Malformed line {number}: {line}")
            continue

        if not relative or len(hash_value) != 64:
            errors.append(f"Malformed line {number}: {line}")
            continue

        expected[relative] = hash_value.upper()

    current_files = {
        path.relative_to(root).as_posix(): path for path in included_files(root)
    }

    for relative, hash_value in expected.items():
        path = root / relative
        if not path.exists():
            errors.append(f"Missing file: {relative}")
            continue
        actual = digest(path)
        if actual != hash_value:
            errors.append(
                f"Hash mismatch: {relative}\n"
                f"  expected {hash_value}\n"
                f"  actual   {actual}"
            )

    missing_from_manifest = sorted(set(current_files) - set(expected))
    for relative in missing_from_manifest:
        errors.append(f"Unlisted file: {relative}")

    stale_entries = sorted(set(expected) - set(current_files))
    for relative in stale_entries:
        if (root / relative).exists():
            errors.append(f"Manifest entry should be excluded: {relative}")

    if errors:
        print("MANIFEST VERIFICATION FAILED", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print("MANIFEST OK")
    print(f"Files verified: {len(expected)}")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=("update", "verify"))
    args = parser.parse_args()

    root = repository_root()
    if args.command == "update":
        return update(root)
    return verify(root)


if __name__ == "__main__":
    raise SystemExit(main())
