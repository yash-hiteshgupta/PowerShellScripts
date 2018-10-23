<#
If using Yahoo mail, the server is "smtp.mail.yahoo.com" and the port is 465.
For Outlook, the server is "smtp-mail.outlook.com" with port 587.
For Gmail, the server is "smtp.gmail.com" with port 587.

###### SYNTAX:
Send-MailMessage
    [-Attachments <String[]>]
    [-Bcc <String[]>]
    [[-Body] <String>]
    [-BodyAsHtml]
    [-Encoding <Encoding>]
    [-Cc <String[]>]
    [-DeliveryNotificationOption <DeliveryNotificationOptions>]
    -From <String>
    [[-SmtpServer] <String>]
    [-Priority <MailPriority>]
    [-Subject] <String>
    [-To] <String[]>
    [-Credential <PSCredential>]
    [-UseSsl]
    [-Port <Int32>]
    [<CommonParameters>]

#>
$CPU = Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average
$Mem = gwmi -Class win32_operatingsystem |
Select-Object @{Name = "MemoryUsage"; Expression = {“{0:N2}” -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }}

$Disk = Get-WmiObject -Class win32_Volume -Filter "DriveLetter = 'C:'" |
Select-object @{Name = "CFree"; Expression = {“{0:N2}” -f (($_.FreeSpace / $_.Capacity)*100) } }

$Outputreport = "<HTML><TITLE> Current Server Health </TITLE>
<H2> Server Health </H2></font>
<Table border=1 cellpadding=5 cellspacing=0>
<TR>
<TD><B>Average CPU</B></TD>
<TD><B>Memory Used</B></TD>
<TD><B>C Drive</B></TD></TR>
<TR>
<TD align=center>$($CPU.Average)%</TD>
<TD align=center>$($MEM.MemoryUsage)%</TD>
<TD align=center>$($Disk."CFree")% Free</TD></TR>
</Table></BODY></HTML>"


$From = "hiteshbdgupta@gmail.com"
$To = "hitesh.gupta@yash.com"
#$Attachment = "D:\Hitesh Gupta\PowerShell\Exploration Scripts\ServerStatus.htm"
$Subject = "Daily Update: Health Report"
$Body = $Outputreport
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"

Send-MailMessage -From $From -to $To -Subject $Subject -BodyAsHtml $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl -Credential (Get-Credential) –DeliveryNotificationOption OnSuccess

echo "Thank You"
#Start-Sleep -s 10

