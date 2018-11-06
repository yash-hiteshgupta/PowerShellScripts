clear
# Adobe PDF Link Helper Registry Path (with CLASS ID)
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{B4F3A835-0E21-4959-BA22-42B3008E02FF}"
if(-not (test-path $RegPAth))
{
    write-host("Path does not exists")
}
else
{
    #CD $RegPath
    Set-Location $RegPath
    write-host("Disabling IE Ext... and Starting IE...will wait.")
    Set-Itemproperty . Flags -Value 1

    Start-Process "$env:ProgramFiles\Internet Explorer\iexplore.exe" -wait # -ArgumentList -extoff

    write-host("IE Done... will Enable Ext now...")

    Set-Itemproperty . Flags -Value 400
    write-host("Enabled IE Ext.")
}


<#


{B4F3A835-0E21-4959-BA22-42B3008E02FF}
Name:                   OneNote Linked Notes
Publisher:              Not Available
Type:                   Browser Extension
Architecture:           32-bit and 64-bit
Version:                Not available
File date:              Not available
Date last accessed:     Not available
Class ID:               {789FE86F-6FC4-46A1-9849-EDE0DB0C95CA}
Use count:              0
Block count:            0
File:                   Not available
Folder:                 Not available
#>