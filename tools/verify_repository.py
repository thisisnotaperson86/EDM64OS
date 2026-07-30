#!/usr/bin/env python3
"""Repository consistency checks for NRMenu."""

from __future__ import annotations

import hashlib
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EXPECTED_OVERRIDE_HASHES = {
    "main.c": "66DE21837C781949FFC6E2C6EFA95113FCC0CF0FDEAA5EAFFA82D7E387C3873B",
    "menu_about.c": "EE02A9A03A25AEB8D223A868E2BF0F9327A61FC71037CCA950EA5CC456322F21",
    "menu_controls.c": "5930A135272E1B49483E2F6F845B9366D88D6715B215CD4356EE3A2D5CD0C5BC",
}
SCREENSHOTS = (
    "docs/images/nrmenu.png",
    "docs/images/nrmenuroms.png",
    "docs/images/nrmenufavs.png",
    "docs/images/nrmenuhist.png",
)
FORBIDDEN_SUFFIXES = {
    ".z64",
    ".n64",
    ".v64",
    ".rom",
    ".nes",
    ".sfc",
    ".smc",
    ".gb",
    ".gbc",
    ".sra",
    ".fla",
    ".eep",
    ".mpk",
}
FORBIDDEN_NAMES = {
    "LASTROM.CFG",
    "FAVORITES.TXT",
    "HISTORY.TXT",
}


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def parse_build_env() -> dict[str, str]:
    values: dict[str, str] = {}
    for raw in (ROOT / "build.env").read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        key, value = line.split("=", 1)
        values[key.strip()] = value.strip()
    return values


def repository_files() -> list[Path]:
    excluded_dirs = {
        ".git",
        "work",
        "dist",
        "backups",
        "export",
        "repo-update-backups",
        "__pycache__",
        ".venv",
        "venv",
    }
    return [
        path
        for path in ROOT.rglob("*")
        if path.is_file()
        and not any(
            part in excluded_dirs for part in path.relative_to(ROOT).parts
        )
    ]


def main() -> int:
    errors: list[str] = []

    config = parse_build_env()
    required = {
        "NRMENU_RELEASE_VERSION",
        "NRMENU_FIRMWARE_LABEL",
        "NRMENU_OUTPUT_NAME",
        "ALTRA64_REPOSITORY",
        "ALTRA64_COMMIT",
        "ALTRA64_DOCKER_IMAGE",
    }
    missing = sorted(required - set(config))
    if missing:
        errors.append(f"Missing build.env keys: {', '.join(missing)}")

    if not re.fullmatch(r"[0-9a-f]{40}", config.get("ALTRA64_COMMIT", "")):
        errors.append("ALTRA64_COMMIT must be a full 40-character lowercase SHA.")

    if not re.fullmatch(
        r"ghcr\.io/ariahiro64/altra64@sha256:[0-9a-f]{64}",
        config.get("ALTRA64_DOCKER_IMAGE", ""),
    ):
        errors.append("ALTRA64_DOCKER_IMAGE must be pinned by sha256 digest.")

    version = (ROOT / "VERSION").read_text(encoding="utf-8").strip()
    if version != config.get("NRMENU_RELEASE_VERSION"):
        errors.append(
            f"VERSION ({version}) does not match build.env "
            f"({config.get('NRMENU_RELEASE_VERSION')})."
        )

    for name, expected in EXPECTED_OVERRIDE_HASHES.items():
        path = ROOT / "overrides" / "src" / name
        if not path.exists():
            errors.append(f"Missing override: {path.relative_to(ROOT)}")
            continue
        actual = sha256(path)
        if actual != expected:
            errors.append(
                f"Stable override changed: {name}\n"
                f"  expected {expected}\n"
                f"  actual   {actual}"
            )

    readme = (ROOT / "README.md").read_text(encoding="utf-8")
    if "## Capturas reales" not in readme:
        errors.append("README.md is missing the 'Capturas reales' section.")

    functions_pos = readme.find("## Principales funciones")
    screenshots_pos = readme.find("## Capturas reales")
    controls_pos = readme.find("## Controles")
    if not (0 <= functions_pos < screenshots_pos < controls_pos):
        errors.append(
            "README screenshot section must be below Principales funciones "
            "and above Controles."
        )

    for relative in SCREENSHOTS:
        path = ROOT / relative
        if not path.exists():
            errors.append(f"Missing screenshot: {relative}")
        if relative not in readme:
            errors.append(f"README does not reference screenshot: {relative}")

    workflow = (ROOT / ".github/workflows/build.yml").read_text(encoding="utf-8")
    for marker in (
        "actions/checkout@v5",
        "actions/upload-artifact@v6",
        "tools/verify_repository.py",
        "ALTRA64_COMMIT",
        "ALTRA64_DOCKER_IMAGE",
    ):
        if marker not in workflow:
            errors.append(f"Workflow is missing marker: {marker}")

    for path in repository_files():
        relative = path.relative_to(ROOT)
        if relative.parts and relative.parts[0] in {".git", "work", "dist", "backups", "export"}:
            continue
        if path.suffix.lower() in FORBIDDEN_SUFFIXES:
            errors.append(f"Forbidden binary/content file: {relative.as_posix()}")
        if path.name.upper() in FORBIDDEN_NAMES:
            errors.append(f"Private runtime data file: {relative.as_posix()}")

    manifest_check = subprocess.run(
        [sys.executable, str(ROOT / "tools/manifest.py"), "verify"],
        cwd=ROOT,
    )
    if manifest_check.returncode != 0:
        errors.append("MANIFEST_SHA256.txt verification failed.")

    if errors:
        print("REPOSITORY VERIFICATION FAILED", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print("REPOSITORY OK")
    print(f"Version: {version}")
    print(f"ALTRA64 commit: {config['ALTRA64_COMMIT']}")
    print(f"Docker image: {config['ALTRA64_DOCKER_IMAGE']}")
    print("Stable C overrides: unchanged")
    print("Screenshots: 4/4")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
