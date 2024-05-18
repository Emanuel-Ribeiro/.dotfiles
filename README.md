#DOTFILES

just run ./setup.sh - so rodar o ./setup.sh

#Comandos uteis (ubuntu)

lembrar de criar o mkdir .config

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
export PATH="$PATH:/opt/nvim-linux64/bin"

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
