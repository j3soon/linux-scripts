#!/bin/bash -e

if [ -f $HOME/.zshrc ]; then
    echo "Error: Already installed."
    exit 1
fi

sudo apt-get install -y zsh
echo "Installed $(zsh --version)."

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "Installed oh-my-zsh."

sudo apt-get install -y fzf
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

sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="agnoster"/g' ~/.zshrc
echo "Set up theme."

echo "Done."

echo "[Optional] Changing default shell... (Ctrl+C to cancel)"
chsh -s $(which zsh)
echo "Changed default shell."

exec zsh