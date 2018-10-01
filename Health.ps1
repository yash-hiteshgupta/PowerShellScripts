$OutputFile="D:\Hitesh Gupta\Scripts\ServerStatus.htm"

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

 

$Outputreport | out-file $OutputFile

 