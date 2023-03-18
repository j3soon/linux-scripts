#!/bin/bash -e

# Install Anydesk
# Ref: https://deb.anydesk.com/howto.html
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
sudo bash -c 'echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list'
sudo apt-get update
sudo apt-get install -y anydesk

# Disable Wayland
# Ref: https://askubuntu.com/a/1148504
sudo sed -i "s/^#.*WaylandEnable.*=.*$/WaylandEnable=false/g" /etc/gdm3/custom.conf
sudo sed -i "s/^#.*AutomaticLoginEnable.*=.*$/AutomaticLoginEnable = true/g" /etc/gdm3/custom.conf
sudo sed -i "s/^#.*AutomaticLogin.*=.*$/AutomaticLogin = $USER/g" /etc/gdm3/custom.conf

# Setup Unattended Access
# Ref: https://support.anydesk.com/knowledge/command-line-interface-for-linux
# Ref: https://gist.github.com/imami/4e8b187e7e1e6fc9510d907eb1a7a5b3
echo "Anydesk ID: $(anydesk --get-id)"
echo -e "ad.security.allow_logon_token=true\nad.features.unattended=true" >> ~/.anydesk/user.conf
read -s -p "Password: " PASSWORD
sudo bash -c "echo $PASSWORD | anydesk --set-password"

read -p "Reboot now (y/n)? " REPLY
if [ "$REPLY" = "y" ]; then
    sudo reboot
fi

echo "Done."
