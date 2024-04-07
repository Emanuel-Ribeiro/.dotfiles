#!/bin/env bash

# function to install packages with error handling / funcao pra instalar pacotes tratando erros
install_packages() {
    for pkg in "$@"; do
        if ! "$@"; then
            echo "Failed to install $pkg"
        fi
    done
}

# update and upgrade package repositories / dar update e upgrade nos repositorios dos pacotes
if command -v apt &> /dev/null; then
    sudo apt update -y && sudo apt upgrade -y
elif command -v yum &> /dev/null; then
    sudo yum update -y && sudo yum upgrade -y
elif command -v dnf &> /dev/null; then
    sudo dnf update -y && sudo dnf upgrade -y
elif command -v pacman &> /dev/null; then
    sudo pacman -Syu --noconfirm
elif command -v brew &> /dev/null; then
    brew update && brew upgrade
else
    echo "Unsupported package manager. Exiting. / Gerenciador de pacotes não suportado. Saindo."
    exit 1
fi

# install essential packages / instalando pacotes essenciais
install_packages() {
    if command -v apt &> /dev/null; then
        sudo apt install "$@" -y
    elif command -v yum &> /dev/null || command -v dnf &> /dev/null; then
        sudo yum install "$@" -y
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm "$@"
    elif command -v brew &> /dev/null; then
        brew install "$@"
    fi
}

install_packages curl npm cargo golang tmux neovim ripgrep i3 zsh

# change default shell to zsh / mudando o shell padrao para o zsh
chsh -s "$(which zsh)"

# install oh my zsh / instalando oh my zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# clone powerlevel10k theme / clonando o tema powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# change ZSH theme to powerlevel10k / mudando o tema do ZSH para o powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# install powerline fonts / instalando a fonte powerline
install_packages fonts-powerline font-powerline-symbols

# install zsh-autosuggestions and zsh-syntax-highlighting plugins / instalando os plugins zsh-autosuggestions e zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# enable plugins in .zshrc / habilitando os plugins no .zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# clone dotfiles repository / clonando o repositorio dos dotfiles
git clone https://github.com/Emanuel-Ribeiro/.dotfiles.git ~/.dotfiles

# create necessary directories and symlink dotfiles / criando diretorios necessarios e links simbolicos
mkdir -p ~/.config/nvim/
mkdir -p ~/.config/i3/
mkdir -p ~/.config/i3status/
ln -sf ~/.dotfiles/nvim ~/.config/nvim/
ln -sf ~/.dotfiles/i3 ~/.config/i3/
ln -sf ~/.dotfiles/i3status ~/.config/i3status/

# install git credential manager core / instalando gerencidor de credenciais do git
if command -v brew &> /dev/null; then
    brew install git-credential-manager-core
else
    sudo curl -L https://aka.ms/gcm/linux-install-source.sh | sudo sh
fi

# configure git credentials / configurando gerenciador de credencias do git
git config --global credential.credentialStore gpg
git-credential-manager configure --system

