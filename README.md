#DOTFILES

sudo apt update
sudo apt install -y stow zsh ripgrep golang gcc curl xsel

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo export PATH="$PATH:/opt/nvim-linux64/bin" >> ~/.zshrc
source ~/.zshrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install --lts

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

ZSHRC="$HOME/.zshrc"

sed -i.bak 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"

source ~/.zshrc

stow .