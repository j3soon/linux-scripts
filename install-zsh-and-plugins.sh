#!/bin/bash -e

if [ -f $HOME/.zshrc ]; then
    echo "Error: Already installed."
    exit 1
fi

sudo apt-get update

sudo apt-get install -y zsh
echo "Installed $(zsh --version)."

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "Installed oh-my-zsh."

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install<&-
echo "Installed fzf $(fzf --version)."

sudo apt-get install -y curl
echo "Installed $(curl --version)."

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "Installed zsh-autosuggestions."

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "Installed zsh-syntax-highlighting."

PLUGINS=$(cat << EOF
plugins=(
    git
    zsh-autosuggestions
    zsh-interactive-cd # sudo apt-get install fzf
    zsh-syntax-highlighting
)

EOF
)
PLUGINS=$(echo "$PLUGINS" | sed -z 's/\n/\\n/g')
sed -i "s/^plugins=.*$/$PLUGINS/g" ~/.zshrc
echo "Set up plugins."

read -p "Change default shell to zsh? (y/n)" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    chsh -s $(which zsh)
    echo "Changed default shell."
fi

read -p "Use powerline theme? (y/n)" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    sudo apt-get install -y fonts-powerline
    echo "Installed fonts-powerline."
    sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="agnoster"/g' ~/.zshrc
    echo "Set up powerline theme."
    echo "Please restart your machine with `sudo reboot`."
fi

echo "Done."

exec zsh