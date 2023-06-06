#!/bin/bash -e

echo "Testing NVIDIA driver installation..."
nvidia-smi
echo "Testing Docker installation..."
docker run --rm hello-world

echo "Begin installing NVIDIA Docker..."
sudo apt-get install -y curl
# Ref: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#setting-up-nvidia-container-toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
   && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
      sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
      sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo apt-get install -y nvidia-container-runtime
sudo systemctl restart docker
docker run --rm --gpus all nvidia/cuda:10.0-base nvidia-smi

echo "Done."
