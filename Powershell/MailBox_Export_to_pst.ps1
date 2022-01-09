#Script exports users' Exchange mailbox to .pst file 
New-MailboxExportRequest <user_login> -FilePath \path\to\folder\filename.pst
#Use this to display export queue and job progress
Get-MailboxExportRequest | Get-MailboxExportRequestStatistics