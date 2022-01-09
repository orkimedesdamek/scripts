#Script displays only active AD group users and counts them
$users = Get-AdGroupMember -Identity "<AD_group_name>"
$count = 0
ForEach ($user in $users)
{
   Get-ADUser -Identity $user.SamAccountName | Where-Object ObjectClass -eq user | Where-Object Enabled -eq True | Select name, enabled
   Get-ADUser -Identity $user.SamAccountName | Where-Object ObjectClass -eq user | Where-Object Enabled -eq True | Select name, enabled | ForEach-Object {$count++}
 }
 Echo $count