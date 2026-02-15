#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="$(realpath "$1")"
if [ -z "$TARGET_DIR" ]; then
    echo "Usage: $0 /path/to/install/WidevineCdm"
    exit 1
fi

TMPDIR=$(mktemp -d)
cd "$TMPDIR"

function cleanup {
    rm -rf "$TMPDIR"
}
trap cleanup EXIT

# Fetch manifest and extract URL
URL=$(python3 -c "
import json, urllib.request
data = json.load(urllib.request.urlopen('https://raw.githubusercontent.com/mozilla/gecko-dev/master/toolkit/content/gmp-sources/widevinecdm.json'))
for v in data['vendors'].values():
    for k, p in v['platforms'].items():
        if 'Linux_x86_64-gcc3' in k:
            print(p['fileUrl'])
            break
")

# Download CRX
curl -L -o widevinecdm.crx "$URL"

# Unpack CRX3 payload (zip archive) without external tools.
python3 - <<'PY'
import struct

with open("widevinecdm.crx", "rb") as src:
    magic = src.read(4)
    if magic != b"Cr24":
        raise SystemExit("unsupported CRX format: missing Cr24 header")
    version = struct.unpack("<I", src.read(4))[0]
    if version != 3:
        raise SystemExit(f"unsupported CRX version: {version}")
    header_len = struct.unpack("<I", src.read(4))[0]
    src.seek(12 + header_len)
    payload = src.read()

with open("widevinecdm.zip", "wb") as dst:
    dst.write(payload)
PY

python3 - <<'PY'
import zipfile
zipfile.ZipFile("widevinecdm.zip").extractall("widevinecdm")
PY

mkdir -p "$TARGET_DIR"
cp -ar widevinecdm/* "$TARGET_DIR"
