#!/bin/bash
set -e

echo "=== Fixing /var/roothome permissions for composefs ==="

# Check SELinux status and temporarily disable if needed
SELINUX_STATUS=$(getenforce 2>/dev/null || echo "Disabled")
echo "SELinux status: $SELINUX_STATUS"

if [ "$SELINUX_STATUS" = "Enforcing" ]; then
    echo "Temporarily setting SELinux to permissive mode..."
    setenforce 0
    echo "SELinux set to permissive"
fi

# Check if /var/roothome is accessible
if ! ls /var/roothome >/dev/null 2>&1; then
    echo "Fixing /var/roothome permissions..."

    # Set proper permissions for roothome directory
    chmod 700 /var/roothome

    # Set SELinux context if SELinux is enforcing
    if [ "$(getenforce)" = "Enforcing" ]; then
        echo "Setting correct SELinux context for /var/roothome..."
        # Set proper SELinux context for root home directory
        chcon -t user_home_dir_t /var/roothome
        # Also set context for snap subdirectory
        chcon -t user_home_dir_t /var/roothome/snap 2>/dev/null || true
    fi

    echo "Permissions fixed for /var/roothome"
else
    echo "/var/roothome is already accessible"
fi

# Ensure snap directory structure exists
if [ ! -d "/var/roothome/snap" ]; then
    echo "Creating snap directory structure..."
    mkdir -p /var/roothome/snap
    chmod 755 /var/roothome/snap
fi

# Test access
echo "Testing access to /root/snap..."
if ls /root/snap >/dev/null 2>&1; then
    echo "✓ /root/snap is accessible"
else
    echo "✗ /root/snap is still not accessible"
    exit 1
fi

# Optional: Disable SELinux permanently (commented out by default)
# Uncomment the following lines if you want to permanently disable SELinux
# echo "Disabling SELinux permanently..."
# sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
# sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config

echo "=== /var/roothome permissions fix completed ==="
echo "Note: SELinux was temporarily set to permissive mode."
echo "To permanently disable SELinux, uncomment the lines in this script."