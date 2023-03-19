#!/bin/bash -e

# Kill & Prevent future "Connect Your Online Accounts" popup
# Ref: https://askubuntu.com/a/1030095
killall gnome-initial-setup
sudo apt-get purge -y gnome-initial-setup

# Update Locale
# Ref: https://askubuntu.com/a/754355
sudo mv /etc/default/locale /etc/default/locale.bak
sudo bash -c 'cat << EOF > /etc/default/locale
#  File generated by update-locale
LANG="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
EOF'

# Install common tools
sudo apt-get update
sudo apt-get install -y vim tmux git curl

# Ubuntu dock
# Ref: https://askubuntu.com/a/992351
gsettings set org.gnome.shell favorite-apps "['firefox_firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'snap-store_ubuntu-software.desktop', 'yelp.desktop']"

read -p "Reboot now (y/n)? " REPLY
if [ "$REPLY" = "y" ]; then
    sudo reboot
fi

echo "Done."
