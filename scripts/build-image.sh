#!/usr/bin/env bash
# Optional helper to download a cloud image and convert to qcow2 (requires qemu-img)
set -euo pipefail
URL=${1:-"https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"}
OUT=${2:-"./images/guest.img"}
mkdir -p "$(dirname "$OUT")"
echo "Downloading ${URL} -> ${OUT}"
curl -L "$URL" -o "$OUT"
echo "Done."
