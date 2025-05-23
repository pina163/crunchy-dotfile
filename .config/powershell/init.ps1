$ConfigPath = "$(Get-Location)"
Write-Debug $ConfigPath

if ($ConfigPath.CompareTo("*crunchy-dotfile\.config\powershell") -ne 1){
    Write-Host "Please change the working directory to the script location"
    Exit
}

$PowershellProfilePath = $PROFILE.CurrentUserCurrentHost
if (Test-Path $PowershellProfilePath) {
    Write-Host "Please delete/back-up existing powershell profile"
    Exit
}
$PowershellDirectoryPath = $(Split-Path -Path $PowershellProfilePath)
# Use Junction substitute of `-ItemType SymbolicLink`
$null = New-Item -ItemType Junction -Value $ConfigPath -Path $PowershellDirectoryPath

Write-Host "Reload Profile.." -NoNewline
. $PowershellProfilePath