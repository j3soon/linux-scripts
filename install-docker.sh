#!/bin/bash -e

sudo apt-get update
sudo apt-get install -y docker.io
sudo usermod -aG docker $USER

read -p "Reboot now (y/n)? " REPLY
if [ "$REPLY" = "y" ]; then
    sudo reboot
fi

echo "Done."
