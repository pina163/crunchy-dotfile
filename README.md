# Usage
## Bash
### Setup
```bash
bash ./crunchy-dotfile/setup/bash.sh
```
### Symlink Dotfiles
Use GNU/Stow to set up symlink
```bash
cd crunchy-dotfile/dotfiles
stow -t $HOME --dotfiles . # for stow all dotfiles
stow -t $HOME -R --dotfiles . # for restow (update) all dotfiles
stow -t $HOME -D --dotfiles . # for unstow all dotfiles
```

## PowerShell
### Setup
```powershell
.\crunchy-dotfile\setup\pwsh.ps1
# or
powershell .\crunchy-dotfile\setup\pwsh.ps1
```

