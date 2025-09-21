function SetUpCore {
	# Set-up pwsh profile
	$ConfigFile = Join-Path -Path $PSScriptRoot -ChildPath "Microsoft.PowerShell_profile.ps1";

	if (-Not $(Test-Path -Path $ConfigFile)) {
		Write-Host "Something wrong with original profile configuration file"
		Exit
	}

	$PowerShellProfilePath = $PROFILE.CurrentUserCurrentHost
	# Write-Host "PROFILE PATH: " $PowerShellProfilePath
	if (Test-Path -Path $PowerShellProfilePath) {
		Write-Host "Delete/back-up existing powershell profile"
		Exit
	}
	# $PowershellDirectoryPath = $(Split-Path -Path $PowerShellProfilePath)
	$null = New-Item -ItemType HardLink -Path $PowerShellProfilePath -Target $ConfigFile
	return $PowerShellProfilePath
}

function SetUpDesktop {
	$OriginalConfigFolder = $PSScriptRoot

	if (-Not $(Test-Path -Path $OriginalConfigFolder)) {
		Write-Host "Something wrong with original profile folder"
	}
	$ProfilePath = $PROFILE.CurrentUserCurrentHost
	$TargetConfigFolder = $(Split-Path -Path $ProfilePath)
	if (Test-Path -Path $TargetConfigFolder) {
		Write-Host "PowerShell profile is existing, please back-up/delete"
	}
	$null = New-Item -ItemType Junction -Path $TargetConfigFolder -Target $OriginalConfigFolder
	return $ProfilePath
}

function SetUpPowerShellProfile {
	if ("Core".Equals($PSVersionTable.PSEdition)) {
		return SetUpCore;
	}
	else {
		return SetUpDesktop;
	}
}

# Set-up oh-my-posh and zoxide
if (Get-Command winget -ErrorAction SilentlyContinue) {
	if (-Not $(Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
		winget install --id JanDeDobbeleer.OhMyPosh
	}
	if (-Not $(Get-Command zoxide -ErrorAction SilentlyContinue)) {
		winget install --id ajeetdsouza.zoxide
	} 
} else {
	Write-Error "Require winget"
	Exit;
}

$ProfilePath = SetUpPowerShellProfile
Write-Host "Reload Profile..." -NoNewline
. $ProfilePath