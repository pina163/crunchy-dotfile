#Requires -RunAsAdministrator
$ConfigPath = "$(Get-Location)"
Write-Debug $ConfigPath

if ($ConfigPath.CompareTo("*crunchy-dotfile\.config\powershell") -ne 1){
    Write-Output "Please change the working directory to the script location"
    Exit
}

$PowershellProfilePath = $PROFILE.CurrentUserCurrentHost
if (Test-Path $PowershellProfilePath) {
    Write-Output "Please delete/back-up existing powershell profile"
    Exit
}
$PowershellDirectoryPath = $(Split-Path -Path $PowershellProfilePath)
New-Item -ItemType SymbolicLink -Value $ConfigPath -Path $PowershellDirectoryPath