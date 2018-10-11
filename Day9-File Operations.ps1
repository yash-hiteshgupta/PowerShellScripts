
$Path = "D:\Hitesh Gupta\PowerShell\Exploration Scripts\ReadMe.txt"
$Data = "Sample text content for PowerShell file operations."

CLEAR

# Test-Path
If(!(Test-Path -Path $Path ))
{
    ## Split-Path
    
    #Throw "$(Split-Path -path $Path -parent) Does not Exist"
    Throw "$Path Does not Exist"
}

# Join-Path
Join-Path -Path $env:temp -ChildPath testing

# Resolve-Path
Resolve-Path -Path "D:\Hitesh Gupta\*\Exploration Scripts"

"This is my text file." | out-file "D:\text.txt"
Get-ChildItem |
     Select-Object Name, Length, LastWriteTime, Fullname |
     Out-File -FilePath "D:\text.txt"


$Data | Add-Content -Path "D:\text.txt"
Get-Content -Path $Path

Get-ChildItem |
     Select-Object Name, Length, LastWriteTime, Fullname | Export-CSV -Path "D:\text.txt"
     
Import-CSV -Path "D:\text.txt"


