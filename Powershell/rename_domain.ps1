#Start-Process powershell -verb runas -ArgumentList "-file fullpathofthescript"
#get elevated permissions
param([switch]$Elevated)
function Check-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Check-Admin) -eq $false)  {
if ($elevated)
{
# could not elevate, quit
}
 
else {
 
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}
exit
}
cls
#Rename computer and ad it to the domain
Write-Host "Rename computer and add it to domain `n"
$CURRENTNAME = (Get-WmiObject Win32_ComputerSystem).Name
$CURRENTDOMAIN = (Get-WmiObject Win32_ComputerSystem).Domain
Write-Host "CURRENT COMPUTER NAME IS: $CURRENTNAME" -ForegroundColor black -BackgroundColor white
Write-Host "CURRENT COMPUTER DOMAIN IS: $CURRENTDOMAIN `n" -ForegroundColor black -BackgroundColor white
$PCNAME = Read-Host -Prompt 'Input your computer name'
$USERNAME = Read-Host -Prompt 'Input your user name'
$CURRUSER = (Get-WMIObject -class Win32_ComputerSystem | select username).username

if ($CURRENTDOMAIN -notlike "*****.intern") {

	write-host "`nEnter your domain username and password to login to ***** `n"  -ForegroundColor black -BackgroundColor white
	Add-Computer -Domain *****.intern -DomainCredential $USERNAME
}else {
   write-host("You are already signed in ****.intern `n")
}

$ADMINRIGHTS = Read-Host -Prompt 'Do you want to add IT&HW Support; LEAD TESTERS; TESTERS to Administrators? (y/n)+Enter'
if ($ADMINRIGHTS -like "y") {
#	-Restart -Force
	write-host("Adding IT&HW Support `n")
	net localgroup administrators "*****\IT&HW Support" /add
	write-host("Adding LEAD TESTERS `n")
	net localgroup administrators "*****\LEAD TESTERS" /add
	write-host("Adding TESTERS `n")
	net localgroup administrators "*****\TESTERS" /add
}else {
Write-Host -NoNewLine 'Press any key...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}
if ($PCNAME -notlike $CURRENTNAME) {

	write-host "`nEnter your domain username and password to modify the PC name `n"  -ForegroundColor black -BackgroundColor white
	Rename-Computer -ComputerName $CURRENTNAME -NewName $PCNAME -DomainCredential $USERNAME
	#Rename-Computer -NewName $PCNAME -ComputerName $CURRENTNAME -WhatIf
}else {
   write-host("`nThis PC name is already set `n")
}

$REBOOTPC = Read-Host -Prompt 'Do you want to restart this computer? (y/n)+Enter'
if ($REBOOTPC -like "y") {
#	-Restart -Force
	Start-Sleep -s 5
	Restart-Computer
}else {
Write-Host -NoNewLine 'Press any key to exit...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}