function SetUpCore {
	# Set-up pwsh profile
	$CrunchyDir = Split-Path -Parent $PSScriptRoot
	$ConfigFile = Join-Path -Path $CrunchyDir -ChildPath "/pwsh/Microsoft.PowerShell_profile.ps1";
	if (-Not $(Test-Path -Path $ConfigFile)) {
		Write-Host "Something wrong with original profile configuration file"
		Exit
	}

	$ProfilePath = $PROFILE.CurrentUserCurrentHost
	Write-Host "PROFILE PATH: " $ProfilePath
	if (Test-Path -Path $ProfilePath) {
		Write-Host "Delete/back-up existing powershell profile"
		Exit
	}
	$null = New-Item -ItemType HardLink -Path $ProfilePath -Target $ConfigFile
	return $ProfilePath
}

function SetUpDesktop {
	$CrunchyDir = Split-Path -Parent $PSScriptRoot
	$OriginalConfigDir = Join-Path -Path $CrunchyDir -ChildPath "/pwsh/";
	if (-Not $(Test-Path -Path $OriginalConfigDir)) {
		Write-Host "Something wrong with original profile folder"
		Exit
	}

	$ProfilePath = $PROFILE.CurrentUserCurrentHost
	Write-Host "PROFILE PATH: " $ProfilePath
	$TargetConfigDir = $(Split-Path -Path $ProfilePath)
	if (Test-Path -Path $TargetConfigDir) {
		Write-Host "PowerShell profile is existing, please back-up/delete"
		Exit
	}
	$null = New-Item -ItemType Junction -Path $TargetConfigDir -Target $OriginalConfigDir
	return $ProfilePath
}

function SetUpPowerShellProfile {
	Write-Host "Setting Up"
	if ("Core".Equals($PSVersionTable.PSEdition)) {
		Write-Host "Powershell Core Edition"
		return SetUpCore;
	}
	else {
		Write-Host "Powershell Desktop Edition"
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
Exit 0;