<#
Date    :    03-10-2018
Created By:  Hitesh Gupta
Description: Sample code for list out some important classes and their methods.
#>

clear
[System.Environment] | Get-Member -Static
write-host("`nUserName : " + [System.Environment]::MachineName)


[System.Math] | Get-Member -Static
write-host("`nMax(2,7) = " + [System.Math]::Max(2,7))

[System.String] | Get-Member -Static
echo `n
$temp = "Hitesh"
[System.String]::IsNullOrEmpty($temp)
$temp = [System.String]::Empty
[System.String]::IsNullOrEmpty($temp)

[System.String]::Compare("A","B")


