#!/bin/bash -e

ubuntu-drivers devices
# Ref: https://forums.developer.nvidia.com/t/ubuntu-22-04-1-nvidia-driver-open-kernel-nvidia-driver-515-open-issue/231356/7
sudo sed -i "s/version = int(package_name\.split('-')\[-1\])$/version = int(package_name.split('-')[2])/g" /usr/lib/python3/dist-packages/UbuntuDrivers/detect.py
sudo ubuntu-drivers autoinstall
# Ref: https://answers.launchpad.net/ubuntu/+source/ubuntu-drivers-common/+question/705811
echo "options nvidia NVreg_OpenRmEnableUnsupportedGpus=1" | sudo tee /etc/modprobe.d/nvreg_fix.conf > /dev/null

read -p "Reboot now (y/n)? " REPLY
if [ "$REPLY" = "y" ]; then
    sudo reboot
fi

echo "Done."
