#!/bin/bash
# Builds BrowserOS.iso using Debian live-build. Run on Debian/Ubuntu as root,
# or let GitHub Actions run it (see README.md).
set -euo pipefail
cd "$(dirname "$0")"
rm -rf work && mkdir work && cd work

lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --archive-areas "main contrib non-free-firmware" \
  --apt-recommends false \
  --debian-installer none \
  --memtest none \
  --iso-volume BROWSEROS \
  --chroot-squashfs-compression-type zstd \
  --bootappend-live "boot=live components quiet noswap"

mkdir -p config/includes.chroot config/package-lists
cp -a ../overlay/. config/includes.chroot/
cp ../package-lists/*.list.chroot config/package-lists/
chmod +x config/includes.chroot/usr/local/bin/*

# Turn on our services (static symlinks, so no hooks are needed)
S=config/includes.chroot/etc/systemd/system
mkdir -p "$S/graphical.target.wants"
ln -sf /etc/systemd/system/browseros.service     "$S/graphical.target.wants/browseros.service"
ln -sf /etc/systemd/system/browseros-web.service "$S/graphical.target.wants/browseros-web.service"
ln -sf /lib/systemd/system/graphical.target      "$S/default.target"

lb build
mv ./*.iso ../BrowserOS.iso
echo "Done: BrowserOS.iso"
