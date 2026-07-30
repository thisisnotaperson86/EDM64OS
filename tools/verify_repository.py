#!/usr/bin/env python3
"""Public repository consistency checks for NRMenu."""

from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parents[1]
REQUIRED_CONFIG = {
    "NRMENU_RELEASE_VERSION",
    "NRMENU_FIRMWARE_LABEL",
    "NRMENU_OUTPUT_NAME",
    "ALTRA64_REPOSITORY",
    "ALTRA64_COMMIT",
    "ALTRA64_DOCKER_IMAGE",
}
REQUIRED_FILES = (
    "README.md",
    "README_EN.md",
    "VERSION",
    "build.env",
    ".github/workflows/build.yml",
    "overrides/src/main.c",
    "overrides/src/menu_about.c",
    "overrides/src/menu_controls.c",
    "docs/images/nrmenu.png",
    "docs/images/nrmenuroms.png",
    "docs/images/nrmenufavs.png",
    "docs/images/nrmenuhist.png",
)
PRIVATE_NAMES = {"LASTROM.CFG", "FAVORITES.TXT", "HISTORY.TXT"}
PRIVATE_SUFFIXES = {".sra", ".fla", ".eep", ".mpk"}
ROM_SUFFIXES = {".n64", ".z64", ".rom", ".nes", ".sfc", ".smc", ".gb", ".gbc"}
EXCLUDED_DIRS = {".git", "work", "dist", "backups", "__pycache__", ".venv", "venv"}
MARKDOWN_LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
HTML_SRC_RE = re.compile(r"(?:src|href)=[\"']([^\"']+)[\"']", re.IGNORECASE)


def parse_build_env() -> dict[str, str]:
    values: dict[str, str] = {}
    path = ROOT / "build.env"
    if not path.exists():
        return values
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if "=" not in line:
            raise ValueError(f"Invalid build.env line: {raw}")
        key, value = line.split("=", 1)
        values[key.strip()] = value.strip()
    return values


def repository_files() -> list[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*"):
        if not path.is_file():
            continue
        parts = path.relative_to(ROOT).parts
        if any(part in EXCLUDED_DIRS for part in parts):
            continue
        files.append(path)
    return files


def local_markdown_targets(path: Path) -> list[str]:
    text = path.read_text(encoding="utf-8", errors="replace")
    targets = MARKDOWN_LINK_RE.findall(text) + HTML_SRC_RE.findall(text)
    result: list[str] = []
    for target in targets:
        target = unquote(target.strip().split()[0].strip("<>"))
        if not target or target.startswith(("http://", "https://", "mailto:", "#")):
            continue
        target = target.split("#", 1)[0].split("?", 1)[0]
        if target:
            result.append(target)
    return result


def main() -> int:
    errors: list[str] = []

    try:
        config = parse_build_env()
    except ValueError as exc:
        errors.append(str(exc))
        config = {}

    missing_keys = sorted(REQUIRED_CONFIG - set(config))
    if missing_keys:
        errors.append(f"Missing build.env keys: {', '.join(missing_keys)}")

    if config and not re.fullmatch(r"[0-9a-f]{40}", config.get("ALTRA64_COMMIT", "")):
        errors.append("ALTRA64_COMMIT must be a full 40-character lowercase SHA.")

    if config and not re.fullmatch(
        r"ghcr\.io/ariahiro64/altra64@sha256:[0-9a-f]{64}",
        config.get("ALTRA64_DOCKER_IMAGE", ""),
    ):
        errors.append("ALTRA64_DOCKER_IMAGE must be pinned by sha256 digest.")

    version_path = ROOT / "VERSION"
    if version_path.exists() and config:
        version = version_path.read_text(encoding="utf-8").strip()
        if version != config.get("NRMENU_RELEASE_VERSION"):
            errors.append(
                f"VERSION ({version}) does not match build.env "
                f"({config.get('NRMENU_RELEASE_VERSION')})."
            )
    else:
        version = "unknown"

    for relative in REQUIRED_FILES:
        path = ROOT / relative
        if not path.is_file() or path.stat().st_size == 0:
            errors.append(f"Missing or empty required file: {relative}")

    readme = ROOT / "README.md"
    if readme.exists():
        readme_text = readme.read_text(encoding="utf-8")
        for screenshot in REQUIRED_FILES[-4:]:
            if screenshot not in readme_text:
                errors.append(f"README.md does not reference screenshot: {screenshot}")

    workflow_path = ROOT / ".github/workflows/build.yml"
    if workflow_path.exists():
        workflow = workflow_path.read_text(encoding="utf-8")
        for marker in (
            "actions/checkout@",
            "actions/upload-artifact@",
            "tools/verify_repository.py",
            "ALTRA64_COMMIT",
            "ALTRA64_DOCKER_IMAGE",
        ):
            if marker not in workflow:
                errors.append(f"Workflow is missing marker: {marker}")

    for path in repository_files():
        relative = path.relative_to(ROOT)
        if path.name.upper() in PRIVATE_NAMES:
            errors.append(f"Private runtime data file: {relative.as_posix()}")
        if path.suffix.lower() in PRIVATE_SUFFIXES:
            errors.append(f"Private save file: {relative.as_posix()}")
        if path.suffix.lower() in ROM_SUFFIXES:
            errors.append(f"Possible ROM file: {relative.as_posix()}")
        if path.suffix.lower() == ".cmd" and path.read_bytes().startswith(b"\xef\xbb\xbf"):
            errors.append(f"CMD file contains UTF-8 BOM: {relative.as_posix()}")

    for markdown in ROOT.rglob("*.md"):
        parts = markdown.relative_to(ROOT).parts
        if any(part in EXCLUDED_DIRS for part in parts):
            continue
        for target in local_markdown_targets(markdown):
            candidate = (markdown.parent / target).resolve()
            try:
                candidate.relative_to(ROOT.resolve())
            except ValueError:
                errors.append(
                    f"Local link escapes repository in {markdown.relative_to(ROOT)}: {target}"
                )
                continue
            if not candidate.exists():
                errors.append(
                    f"Broken local link in {markdown.relative_to(ROOT)}: {target}"
                )

    if errors:
        print("REPOSITORY VERIFICATION FAILED", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print("REPOSITORY OK")
    print(f"Version: {version}")
    if config:
        print(f"ALTRA64 commit: {config['ALTRA64_COMMIT']}")
        print(f"Docker image: {config['ALTRA64_DOCKER_IMAGE']}")
    print("Required files and screenshots: OK")
    print("Local documentation links: OK")
    print("Private runtime data / obvious ROM files: not found")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
