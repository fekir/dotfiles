# Copy this file in
#  C:/Windows/System32/WindowsPowerShell/v1.0/profile.ps1
# or
#  ~/Documents/WindowsPowerShell/profile.ps1

Set-PSReadLineOption -EditMode Emacs;

# Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
Set-PSReadLineKeyHandler -Key Ctrl+Shift+C -Function Copy;
Set-PSReadLineKeyHandler -Key Ctrl+Shift+V -Function Paste;

# unclear what bets option is
# ascii better than utf-8 for binary data
# NoNewLine avoids converting \n to \r\n
# see also https://github.com/PowerShell/powershell/pull/17857
$PSDefaultParameterValues['Out-File:Encoding'] = 'ascii'
$PSDefaultParameterValues['Out-File:NoNewLine'] = $true

Remove-Item -ErrorAction SilentlyContinue Alias:ls;
function ls([string] $dir=".") { (Get-ChildItem $dir).Name; }
Set-Alias -Name ll -Value Get-ChildItem;
Set-Alias -Name l -Value ls;
function la { (Get-ChildItem -Force).Name; }

Remove-Item -ErrorAction SilentlyContinue Alias:pwd;
function pwd { (Convert-Path .).Replace("\", "/"); }

function touch([string] $filename){ if(!(Test-Path $filename)) { New-Item -Path $filename -ItemType File; }; }

# some tools (nvim at least) have issue with some TERM values set in powershell (for example powershell executed from cygwin, wsl, ...)
# since powershell (at least on Windows) does not use it, removing it should not harm
$env:TERM=''

if(Test-Path "C:/Program Files/Midnight Commander/libexec/mc-wrapper.ps1") {
  Set-Alias -Name mc -Value "C:/Program Files/Midnight Commander/libexec/mc-wrapper.ps1";
}

function prompt {
  $esc = [char]27;
  return "$esc[32m$env:UserName" + " $pwd".Replace(" $home", " ~").Replace("\", "/") + "$esc[33m >$esc[0m ";
}

# programs and env variables are actually better handled outside of powershell
# so that behaviour is consistent with cmd.exe and explorer.exe
if((Test-Path "C:/Program Files/Neovim/bin/nvim.exe") -and !(Get-Command "nvim" -ErrorAction SilentlyContinue)){
  Set-Alias -Name nvim -Value "C:/Program Files/Neovim/bin/nvim.exe";
}
if(Test-Path "C:/Program Files/notepad++/notepad.exe"){
  Set-Alias -Name "notepad++" -Value "C:/Program Files/notepad++/notepad.exe";
  Set-Alias -Name "npp"       -Value "C:/Program Files/notepad++/notepad.exe";
}
