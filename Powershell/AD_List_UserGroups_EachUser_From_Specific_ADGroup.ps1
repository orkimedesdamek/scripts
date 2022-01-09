#Script lists groups the user is a member of. The list of users is taken from some AD group. Output file is created for each user
$users = Get-AdGroupMember -Identity "<AD_group_name>"
$SearchPattern = "<search_pattern>" #Here can be any search pattern, for example "^Admin_" if you need to list only specific groups user is a member of
ForEach ($user in $users)
{
 $printname = Get-AdUser -Identity $user.SamAccountName | Select-Object -ExpandProperty SamAccountName
 $outputpath = "path\to\output\file\" + $printname + "_groups.txt"
 Get-ADPrincipalGroupMembership -Identity $user.SamAccountName | Select-Object -ExpandProperty name | Sort-Object name | Select-String -Pattern $SearchPattern | Out-File -FilePath $outputpath -Encoding utf8 #For output to .csv use | Export-Csv -Path $outputpath -Encoding UTF8
 }

#For single user
#$user = "<user_login>"
#$SearchPattern = "<search_pattern>"
#$outputpath = "path\to\output\file\" + $user + "_groups.txt"
#Get-ADPrincipalGroupMembership -Identity $user | Select-Object -ExpandProperty name | Sort-Object name | Select-String -Pattern $SearchPattern | Out-File -FilePath $outputpath -Encoding utf8