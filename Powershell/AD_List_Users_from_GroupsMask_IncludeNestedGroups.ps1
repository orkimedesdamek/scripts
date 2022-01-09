#Script for listing members of a set of groups
#For each group, a separate file is created, if the group includes another group (Nested Group), members of it are added to the end of the file
#(including groups' nested groups, the names of these groups are not written, only users, the -Recursive parameter in the second loop is responsible for this)
#
#Define set of groups, search pattern can be different, for example "^Admin_*" - all groups which name starts with Admin_
$groups = Get-ADGroup -Filter {name -like "<search_pattern>"}
#Loop through each group from set
ForEach ($group in $groups)
{
 #Define vars
 $outputpath = "path\to\file\" + $group.SamAccountName + "_users.csv"
 $ifgroups = Get-ADGroupMember -Identity $group.SamAccountName | where-object {$_.objectClass -eq 'group'}
 #Here is magic
 Get-ADGroupMember -Identity $group.SamAccountName | where-object {$_.objectClass -eq 'user'} | Select name | Sort-Object name | Out-File $outputpath -Encoding default
 #Check for Nested Groups
 if ($ifgroups.objectClass -like 'group')
  {
   ForEach ($ifgroup in $ifgroups)
   {
    Add-Content $outputpath "`nIncluding users from group $($ifgroup.Name) and all nested groups"
    Get-ADGroupMember -Identity $ifgroup.SamAccountName -Recursive | Select name | Sort-Object name | Out-File $outputpath -Encoding default -Append
   }
  }
}