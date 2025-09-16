#!/bin/bash
set -e

# Install Juju
snap install juju --classic

# Install Charmed Kubeflow
# Note: This installs the tools but doesn't deploy yet
# Deployment requires a running Kubernetes cluster
echo "Charmed Kubeflow tools installed. To deploy:"
echo "1. Set up a Kubernetes cluster (e.g., microk8s)"
echo "2. Run: juju bootstrap <cloud> <controller-name>"
echo "3. Run: charmed-kubeflow.deploy"
