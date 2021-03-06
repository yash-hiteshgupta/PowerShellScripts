<#
Date    :    04-10-2018
Created By:  Hitesh Gupta
Description: Sample code for DateTime.
#>

clear

[System.DateTime] | Get-Member -Static
$time = [System.DateTime]::Today
echo `n
$time.DayOfWeek

clear
Get-Date -Format d
Get-Date -Format t
Get-Date -Year 2019 -Month 12 -Day 31 -Hour 23 -Minute 59 -Second 59 

clear
$today = Get-Date
$today.DayOfWeek
$today.Year
$today.AddDays(-1)
$today.AddMonths(1)
$today.ToShortDateString()

$today | Get-Member -Static


