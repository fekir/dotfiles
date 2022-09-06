# Copy this file in ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1

$PSReadLineOptions = @{
	EditMode = "Emacs"
	HistoryNoDuplicates = $true
	# avoid using grey, otherwise on solarized terminal it's too hard to see
	Colors = @{
		Command            = 'DarkGreen'
		Number             = 'DarkGreen'
		Member             = 'DarkGreen'
		Operator           = 'DarkGreen'
		Type               = 'DarkGreen'
		Variable           = 'DarkGreen'
		Parameter          = 'DarkGreen'
		ContinuationPrompt = 'DarkGreen'
		Default            = 'DarkGreen'
	}
}
Set-PSReadLineOption @PSReadLineOptions;

# Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
Set-PSReadLineKeyHandler -Key Ctrl+Shift+C -Function Copy;
Set-PSReadLineKeyHandler -Key Ctrl+Shift+V -Function Paste;


Remove-Item -ErrorAction SilentlyContinue Alias:ls;
function ls([string] $dir=".") { (Get-ChildItem $dir).Name; }
Set-Alias -Name ll -Value Get-ChildItem;
Set-Alias -Name l -Value ls;
function la { (Get-ChildItem -Force).Name; }

Remove-Item -ErrorAction SilentlyContinue Alias:pwd;
function pwd { "$pwd".Replace("\", "/"); }

if(Get-Command "nvim" -ErrorAction SilentlyContinue){
	Set-Alias -Name vim -Value nvim;
	Set-Alias -Name vi  -Value nvim;
	Set-Alias -Name e   -Value nvim;
}elseif(Get-Command "vim" -ErrorAction SilentlyContinue){
	Set-Alias -Name vi  -Value vim;
	Set-Alias -Name e   -Value vim;
}elseif(Get-Command "vi" -ErrorAction SilentlyContinue){
	Set-Alias -Name e   -Value vi;
}

if(Get-Command "notepad++" -ErrorAction SilentlyContinue){
	Set-Alias -Name npp -Value "notepad++";
}elseif(Test-Path "C:/Program Files/Notepad++/notepad++.exe"){
	Set-Alias -Name npp -Value "C:/Program Files/Notepad++/notepad++.exe";
	Set-Alias -Name "notepad++" -Value "C:/Program Files/Notepad++/notepad++.exe";
}

function touch([string] $filename){ if (!(Test-Path $filename)) { New-Item -Path $filename -ItemType File }; }

function prompt {
	$esc = [char]27;
	return "$esc[32m$env:UserName" + " $esc[36m$pwd".Replace(" $esc[36m$home", " $esc[36m~").Replace("\", "/") + "$esc[33m >$esc[0m ";
}
