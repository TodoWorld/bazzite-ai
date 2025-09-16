#!/bin/bash
set -e

# 初始化snapd
#systemctl enable --now snapd.socket
#systemctl start snapd.service

# 創建必要的符號鏈接
ln -sf /var/lib/snapd/snap /snap

# 等待snapd準備就緒
snap wait system seed.loaded

# 安裝juju
snap install juju --classic

# 安裝charmed-kubeflow
juju deploy kubeflow --channel 1.10/stable

echo "Charmed Kubeflow tools installed. To deploy:"
echo "1. Set up a Kubernetes cluster (e.g., microk8s)"
echo "2. Run: juju bootstrap <cloud> <controller-name>"
echo "3. Run: charmed-kubeflow.deploy"
