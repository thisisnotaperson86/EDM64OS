#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK="$ROOT/work/altra64"
DIST="$ROOT/dist"
FRESH="${1:-}"
if [[ "$FRESH" == "--fresh" ]]; then rm -rf "$WORK"; fi
command -v git >/dev/null || { echo "Git no instalado"; exit 1; }
command -v docker >/dev/null || { echo "Docker no instalado"; exit 1; }
docker info >/dev/null
if [[ ! -d "$WORK/.git" ]]; then
  mkdir -p "$(dirname "$WORK")"
  git clone --depth 1 https://github.com/ariahiro64/altra64.git "$WORK"
fi
cp "$ROOT/overrides/src/main.c" "$WORK/src/main.c"
cp "$ROOT/overrides/src/menu_about.c" "$WORK/src/menu_about.c"
cp "$ROOT/overrides/src/menu_controls.c" "$WORK/src/menu_controls.c"
docker run --rm -v "$WORK:/build" ghcr.io/ariahiro64/altra64:master make clean
docker run --rm -v "$WORK:/build" ghcr.io/ariahiro64/altra64:master make
mkdir -p "$DIST"
cp "$WORK/bin/OS64P.v64" "$DIST/OS64P_NRMENU_v1.0.v64"
python3 - "$DIST/OS64P_NRMENU_v1.0.v64" <<'VERIFY'
import sys, hashlib
p=sys.argv[1]
b=open(p,'rb').read()
assert len(b)==4194304, len(b)
assert b[:4]==bytes.fromhex('80 37 12 40'), b[:4].hex()
assert b[32:52].decode('ascii','ignore').strip()=='ED64Plus OS'
h=hashlib.sha256(b).hexdigest().upper()
open(p+'.sha256','w').write(f'{h}  OS64P_NRMENU_v1.0.v64\n')
print('BUILD OK')
print('SHA256:',h)
VERIFY
