# /usr/bin/env bash
if ! command -v oh-my-posh &>/dev/null
then
	if ! command -v zip &>/dev/null
	then
		sudo apt-get install zip
	fi
	curl -s https://ohmyposh.dev/install.sh | bash -s
fi
if ! command -v zoxide &>/dev/null;
then
	sudo apt-get install fzf zoxide
fi

# TODO stow with dotfiles dir location
SCRIPT_DIR=$( cd -P -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CRUNCHY_DIR=$(dirname -- $SCRIPT_DIR)
DOTFILE_DIR="$CRUNCHY_DIR/dotfiles"
if ! command -v stow &>/dev/null
then
	echo "GNU/stow is not available not automatically link dotfiles and source"
	exit 0
fi

stow -d $DOTFILE_DIR -t $HOME .
source $HOME/.bashrc