# https://learn.microsoft.com/en-us/troubleshoot/developer/visualstudio/cpp/libraries/c-runtime-packages-desktop-bridge#how-to-install-and-update-desktop-framework-packages
# install winget if not installed (should always be installed but for sandbox it isn't)

Invoke-WebRequest -URI "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -OutFile vcl.appx
Add-AppxPackage vcl.appx

Invoke-WebRequest -URI "https://github.com/microsoft/winget-cli/releases/download/v1.4.3531/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile winget.msixbundle
Add-AppxPackage winget.msixbundle


# rancher for windows and docker for linux
# maybe not rancher yet cause it's a bit buggy
# winget install -e --id suse.RancherDesktop
# winget install -e --id Docker.DockerDesktop
# winget install -e --id Microsoft.VisualStudioCode
# winget install -e --id Google.Chrome
# winget install -e --id Microsoft.WindowsTerminal

# https://learn.microsoft.com/en-us/windows/terminal/tutorials/custom-prompt-setup
winget install XP8K0HKJFRXGCK
# install font
Invoke-WebRequest -URI "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip" -Out FiraCode.zip
Invoke-WebRequest -URI "https://github.com/microsoft/terminal/releases/download/v1.15.3465.0/Microsoft.WindowsTerminal_Win10_1.15.3465.0_8wekyb3d8bbwe.msixbundle" -Out terminal.msixbundle
Add-AppxPackage terminal.msixbundle
# extract zip to C:\Windows\fonts

# source control terminal config file too

Set-ExecutionPolicy RemoteSigned
mkdir -p C:\Users\WDAGUtilityAccount\Documents\WindowsPowerShell
notepad $PROFILE
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
Set-ExecutionPolicy Restricted
# install wsl
# install ubuntu from a tar
# run setup linux-setup.sh in container
wsl --install

