# /usr/bin/env bash

# prep utilitie command
if ! command -v zip &>/dev/null; then
	echo "install zip"
	sudo apt-get install zip
fi
if ! command -v curl &>/dev/null; then
	echo "install curl"
	sudo apt-get install curl
fi
if ! command -v stow &>/dev/null; then
	echo "install stow"
	sudo apt-get install stow
fi

# install tools
if ! command -v oh-my-posh &>/dev/null; then
	echo "install oh-my-posh"
	curl -s https://ohmyposh.dev/install.sh | bash -s
fi
if ! command -v zoxide &>/dev/null; then
	echo "install fzf and zoxide"
	sudo apt-get install fzf zoxide
fi

if ! command -v nvim &>/dev/null; then
	echo "install nvim"
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
fi

# setup stow
SCRIPT_DIR=$( cd -P -- "$( dirname -- "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )
CRUNCHY_DIR=$(dirname -- $SCRIPT_DIR)
DOTFILE_DIR="$CRUNCHY_DIR/dotfiles"

if ! command -v stow &>/dev/null; then
	echo "GNU/stow is not available not automatically link dotfiles and source"
	exit 0
fi

echo "start restow the dotfiles"
stow -R -d $DOTFILE_DIR -t $HOME --dotfiles .
echo "complete restow the dotfiles"

echo "source .bashrc"
source $HOME/.bashrc
echo "complete..."