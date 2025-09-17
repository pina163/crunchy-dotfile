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