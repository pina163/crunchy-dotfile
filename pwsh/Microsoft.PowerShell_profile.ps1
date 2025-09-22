$Env:GIT_SSH = $((Get-Command -Name ssh).Source)
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
	oh-my-posh init pwsh --config "$HOME/crunchy-dotfile/template/ohmyposh/lean.omp.toml" | Invoke-Expression
}
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
	Invoke-Expression (& { (zoxide init powershell | Out-String) })
	# Set-Alias -Name cd -Value z -Option AllScope -Scope Global -Force
}
