# Copy this file in
#  C:/Windows/System32/WindowsPowerShell/v1.0/profile.ps1
# or
#  ~/Documents/WindowsPowerShell/profile.ps1

Set-PSReadLineOption -EditMode Emacs;

# Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
Set-PSReadLineKeyHandler -Key Ctrl+Shift+C -Function Copy;
Set-PSReadLineKeyHandler -Key Ctrl+Shift+V -Function Paste;

$PSDefaultParameterValues['Out-File:Encoding'] = 'ascii'
$PSDefaultParameterValues['Out-File:NoNewLine'] = $true

Remove-Item -ErrorAction SilentlyContinue Alias:ls;
function ls([string] $dir=".") { (Get-ChildItem $dir).Name; }
Set-Alias -Name ll -Value Get-ChildItem;
Set-Alias -Name l -Value ls;
function la { (Get-ChildItem -Force).Name; }

Remove-Item -ErrorAction SilentlyContinue Alias:pwd;
function pwd { (Get-Location).Path.Replace("\", "/"); }

function touch([string] $filename){ if(!(Test-Path $filename)) { New-Item -Path $filename -ItemType File; }; }

# some tools (nvim at least) have issue with some TERM values set in powershell
# since powershell does not use it, removing it should not harm
$env:TERM=''

$env:PATH="$env:PATH;$env:USERPROFILE\bin";

# add common tools even if not in Path

if((Test-Path "C:/Program Files/Neovim/bin/nvim.exe") -and !(Get-Command "nvim" -ErrorAction SilentlyContinue)){
  Set-Alias -Name nvim -Value "C:/Program Files/Neovim/bin/nvim.exe";
}elseif((Test-Path "C:/tools/nvim-win64/bin/nvim.exe") -and !(Get-Command "nvim" -ErrorAction SilentlyContinue)){
  # location used by chocolatey
  Set-Alias -Name nvim -Value "C:/tools/nvim-win64/bin/nvim.exe";
}

if(Test-Path "C:/Program Files/Vim/vim91/"){
  # FIXME: query path
  if(!(Get-Command "vim" -ErrorAction SilentlyContinue)){
    Set-Alias -Name nvim -Value "C:/Program Files/Vim/vim91/vim.exe";
  }
  if(!(Get-Command "gvim" -ErrorAction SilentlyContinue)){
    Set-Alias -Name gvim -Value "C:/Program Files/Vim/vim91/gvim.exe";
  }
}


# make vi aliases consistent
if(Get-Command "nvim" -ErrorAction SilentlyContinue){
    Set-Alias -Name editor -Value nvim;
    Set-Alias -Name vim    -Value nvim;
    Set-Alias -Name vi     -Value nvim;
    Set-Alias -Name e      -Value nvim;
}elseif(Get-Command "vim" -ErrorAction SilentlyContinue){
    Set-Alias -Name editor -Value vim;
    Set-Alias -Name vi     -Value vim;
    Set-Alias -Name e      -Value vim;
}elseif(Get-Command "vi" -ErrorAction SilentlyContinue){
    Set-Alias -Name editor -Value vi;
    Set-Alias -Name e      -Value vi;
}


# set bat as predefined VISUAL if available
# add dua, btop, ...

# FIXME: need something like realpath or external programs cannot use it
#if(Get-Command "editor" -ErrorAction SilentlyContinue){
#  $env:EDITOR="editor";
#  $env:VISUAL="editor";
#}



if(Test-Path "C:/Program Files (x86)/Midnight Commander/mc.exe"){
  [Environment]::SetEnvironmentVariable("MC_PROFILE_ROOT", "$env:USERPROFILE/./", [System.EnvironmentVariableTarget]::User)
  if(!(Get-Command "mc" -ErrorAction SilentlyContinue)){
    Set-Alias -Name mc -Value "C:/Program Files (x86)/Midnight Commander/mc.exe";
    if(Test-Path "C:/Program Files (x86)/Midnight Commander/mc-wrapper.ps1") {
      Set-Alias -Name mc -Value "C:/Program Files (x86)/Midnight Commander/mc-wrapper.ps1";
    }
  }
}

if((Test-Path "C:/Program Files/Far Manager/Far.exe") -and !(Get-Command "far" -ErrorAction SilentlyContinue)){
  Set-Alias -Name far -Value "C:/Program Files/Far Manager/Far.exe";
}


function prompt {
  $esc = [char]27;
  return "$esc[32m$env:UserName" + " $pwd".Replace(" $home", " ~").Replace("\", "/") + "$esc[33m >$esc[0m ";
}


# some gui programs
if(Test-Path "C:/Program Files/notepad++/notepad.exe"){
  Set-Alias -Name "notepad++" -Value "C:/Program Files/notepad++/notepad.exe";
  Set-Alias -Name "npp"       -Value "C:/Program Files/notepad++/notepad.exe";
}
