#!/bin/env bash

# color codes / codigo de cores
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# function to install packages with error handling / funcao para instalar pacotes tratando os erros
install_packages() {
    for pkg in "$@"; do
        if command -v apt &> /dev/null; then
            if ! sudo apt install "$pkg" -y; then
                echo -e "${RED}Failed to install $pkg${NC} / ${RED}Falha ao instalar o pacote $pkg${NC}"
            fi
        elif command -v yum &> /dev/null || command -v dnf &> /dev/null; then
            if ! sudo yum install "$pkg" -y; then
                echo -e "${RED}Failed to install $pkg${NC} / ${RED}Falha ao instalar o pacote $pkg${NC}"
            fi
        elif command -v pacman &> /dev/null; then
            if ! sudo pacman -S --noconfirm "$pkg"; then
                echo -e "${RED}Failed to install $pkg${NC} / ${RED}Falha ao instalar o pacote $pkg${NC}"
            fi
        elif command -v brew &> /dev/null; then
            if ! brew install "$pkg"; then
                echo -e "${RED}Failed to install $pkg${NC} / ${RED}Falha ao instalar o pacote $pkg${NC}"
            fi
        fi
    done
}

# update and upgrade package repositories / atualiza os repositorios dos pacotes
if command -v apt &> /dev/null; then
    if ! sudo apt update -y && sudo apt upgrade -y; then
        echo -e "${RED}Failed to update and upgrade package repositories${NC} / ${RED}Falha ao atualizar os repositorios de pacotes${NC}"
        exit 1
    fi

elif command -v yum &> /dev/null; then
    if ! sudo yum update -y && sudo yum upgrade -y; then
        echo -e "${RED}Failed to update and upgrade package repositories${NC} / ${RED}Falha ao atualizar os repositorios de pacotes${NC}"
        exit 1
    fi

elif command -v dnf &> /dev/null; then
    if ! sudo dnf update -y && sudo dnf upgrade -y; then
        echo -e "${RED}Failed to update and upgrade package repositories${NC} / ${RED}Falha ao atualizar os repositorios de pacotes${NC}"
        exit 1
    fi

elif command -v pacman &> /dev/null; then
    if ! sudo pacman -Syu --noconfirm; then
        echo -e "${RED}Failed to update and upgrade package repositories${NC} / ${RED}Falha ao atualizar os repositorios de pacotes${NC}"
        exit 1
    fi

elif command -v brew &> /dev/null; then
    if ! brew update && brew upgrade; then
        echo -e "${RED}Failed to update and upgrade package repositories${NC} / ${RED}Falha ao atualizar os repositorios de pacotes${NC}"
        exit 1
    fi

else
    echo -e "${RED}Unsupported package manager. Exiting.${NC} / ${RED}Gerenciador de pacotes não suportado. Saindo.${NC}"
    exit 1
fi

# install essential packages / instalando pacotes essenciais
install_packages curl npm cargo golang tmux neovim ripgrep i3 zsh pass maim

# change default shell to zsh / mudando o shell padrao para zsh
if ! chsh -s "$(which zsh)"; then
    echo -e "${RED}Failed to change default shell to zsh${NC} / ${RED}Falha ao definir zsh como shell padrao${NC}"
    exit 1
fi

# install oh my zsh if not already installed / instalando oh my zsh se ja nao estiver instalado
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    if ! bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
        echo -e "${RED}Failed to install Oh My Zsh${NC} / ${RED}Falha ao instalar o Oh My Zsh${NC}"
        exit 1
    fi

else
    echo -e "${GREEN}Oh My Zsh is already installed${NC} / ${GREEN}Oh My Zsh ja estava instalado${NC}"
fi

# clone powerlevel10k theme / clonando o tema powerlevel10k
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

if ! git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"; then
    echo -e "${RED}Failed to clone powerlevel10k${NC} / ${RED}Falha ao clonar o powerlevel10k${NC}"
    exit 1
fi

# change ZSH theme to powerlevel10k / mudando o tema do ZSH para o powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# install powerline fonts / instalando fonte powerline
if ! sudo apt install fonts-powerline -y; then
    echo -e "${RED}Failed to install powerline fonts${NC} / ${RED}Falha ao instalar a fonte power-line${NC}"
    exit 1
fi

# install zsh-autosuggestions and zsh-syntax-highlighting plugins / instalando os plugins zsh-autosuggestions e zsh-syntax-highlighting
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

if ! git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"; then
    echo -e "${RED}Failed to clone zsh-autosuggestions plugin${NC} / ${RED}Falha ao clonar o plugin zsh-autosuggestions${NC}"
    exit 1
fi

if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"; then
    echo -e "${RED}Failed to clone zsh-syntax-highlighting plugin${NC} / ${RED}Falha ao clonar o plugin zsh-syntax-highlighting${NC}"
    exit 1
fi

# enable plugins in .zshrc / habilitando plugins no .zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# create symlink / criando links simbolicos 
rm -rf ~/.config/nvim/ ~/.config/i3/ ~/.config/i3status/
if ! ln -sf ~/.dotfiles/nvim ~/.config/ || ! ln -sf ~/.dotfiles/i3 ~/.config/ || ! ln -sf ~/.dotfiles/i3status ~/.config/; then
    echo -e "${RED}Failed to create symbolic links for dotfiles${NC} / ${RED}Falha ao criar links simbolicos para os dotfiles${NC}"
    exit 1
fi

# configuring git credentials / configurando credenciais do git
# wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.4.1/gcm-linux_amd64.2.4.1.tar.gz
# sudo tar -xvf gcm-linux_amd64.2.4.1.tar.gz -C /usr/local/bin
# sudo git-credential-manager configure --system
# git config --global credential.credentialStore gpg
# gpg --full-generate-key
# pass init <gpgkey>

echo -e "${GREEN}Setup completed successfully${NC} / ${GREEN}Setup concluido com sucesso${NC}"
