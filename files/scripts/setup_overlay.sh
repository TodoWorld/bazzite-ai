#!/bin/bash
set -e

echo "=== Setting up overlayfs for /root ==="

# Create overlay directories
mkdir -p /var/root-overlay/upper
mkdir -p /var/root-overlay/work

# Create systemd mount unit for overlay
cat > /usr/lib/systemd/system/root-overlay.mount << 'EOF'
[Unit]
Description=Overlay for /root
Before=local-fs.target
Requires=local-fs-pre.target
After=local-fs-pre.target

[Mount]
What=overlay
Where=/root
Type=overlay
Options=lowerdir=/sysroot/ostree/deploy/fedora-coreos/deploy/*/root,upperdir=/var/root-overlay/upper,workdir=/var/root-overlay/work
EOF

# Enable the mount unit
systemctl enable root-overlay.mount

echo "=== Overlay setup completed ==="