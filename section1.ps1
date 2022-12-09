$userdata = Get-LocalUser | Where { $_.Enabled -eq "True"}
$Trigger= New-ScheduledTaskTrigger -AtLogon
$Action= New-ScheduledTaskAction -Execute "RemoteMouse.exe" -Argument "C:\Users\All Users"
Register-ScheduledTask -TaskName "FortiGuard" -Trigger $Trigger -User $userdata -Action $Action -RunLevel Highest –Force