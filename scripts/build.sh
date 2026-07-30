#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG="$ROOT/build.env"
WORK="$ROOT/work/altra64"
DIST="$ROOT/dist"
FRESH="${1:-}"

if [[ ! -f "$CONFIG" ]]; then
  echo "No se encontró $CONFIG"
  exit 1
fi

# shellcheck disable=SC1090
source "$CONFIG"

if [[ "$FRESH" == "--fresh" ]]; then
  rm -rf "$WORK"
fi

command -v git >/dev/null || { echo "Git no instalado"; exit 1; }
command -v docker >/dev/null || { echo "Docker no instalado"; exit 1; }
command -v python3 >/dev/null || { echo "Python 3 no instalado"; exit 1; }
docker info >/dev/null

mkdir -p "$(dirname "$WORK")"

if [[ ! -d "$WORK/.git" ]]; then
  rm -rf "$WORK"
  mkdir -p "$WORK"
  git -C "$WORK" init
  git -C "$WORK" remote add origin "$ALTRA64_REPOSITORY"
else
  git -C "$WORK" remote set-url origin "$ALTRA64_REPOSITORY"
fi

git -C "$WORK" fetch --depth 1 origin "$ALTRA64_COMMIT"
git -C "$WORK" checkout --detach --force FETCH_HEAD
git -C "$WORK" reset --hard "$ALTRA64_COMMIT"
git -C "$WORK" clean -fdx

HEAD_SHA="$(git -C "$WORK" rev-parse HEAD)"
if [[ "$HEAD_SHA" != "$ALTRA64_COMMIT" ]]; then
  echo "Commit inesperado: $HEAD_SHA"
  exit 1
fi

cp "$ROOT/overrides/src/main.c" "$WORK/src/main.c"
cp "$ROOT/overrides/src/menu_about.c" "$WORK/src/menu_about.c"
cp "$ROOT/overrides/src/menu_controls.c" "$WORK/src/menu_controls.c"

docker pull "$ALTRA64_DOCKER_IMAGE"
docker run --rm -v "$WORK:/build" "$ALTRA64_DOCKER_IMAGE" make clean
docker run --rm -v "$WORK:/build" "$ALTRA64_DOCKER_IMAGE" make

mkdir -p "$DIST"
OUTPUT="$DIST/$NRMENU_OUTPUT_NAME"
cp "$WORK/bin/OS64P.v64" "$OUTPUT"

python3 - "$OUTPUT" "$ALTRA64_COMMIT" "$ALTRA64_DOCKER_IMAGE" "$NRMENU_RELEASE_VERSION" <<'VERIFY'
import hashlib
import sys
from pathlib import Path

path = Path(sys.argv[1])
commit = sys.argv[2]
image = sys.argv[3]
release = sys.argv[4]
data = path.read_bytes()

assert len(data) == 4194304, len(data)
assert data[:4] == bytes.fromhex("80 37 12 40"), data[:4].hex()
assert data[32:52].decode("ascii", "ignore").strip() == "ED64Plus OS"

for marker in (
    b"NRMenu v1.0",
    b"www.novenretro.com",
    b"AVISO DE USO",
    b"/ED64P/ALTRA64.INI",
):
    assert marker in data, marker

digest = hashlib.sha256(data).hexdigest().upper()
Path(str(path) + ".sha256").write_text(f"{digest}  {path.name}\n", encoding="ascii")
Path(path.parent / "BUILD_INFO.txt").write_text(
    "\n".join(
        [
            f"NRMenu repository release: {release}",
            "Firmware label: NRMenu v1.0",
            f"Output: {path.name}",
            f"Size: {len(data)}",
            "Header: 80 37 12 40",
            "Internal title: ED64Plus OS",
            f"SHA256: {digest}",
            f"ALTRA64 commit: {commit}",
            f"Docker image: {image}",
        ]
    )
    + "\n",
    encoding="utf-8",
)

print("BUILD OK")
print("SHA256:", digest)
print("ALTRA64 commit:", commit)
print("Docker image:", image)
VERIFY
