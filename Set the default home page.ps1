<#
    Name: Hitesh Gupta
    Date: 30 Oct. 2018
    Description: Change Home page value in registry.
#>
$path = 'HKCU:\Software\Microsoft\Internet Explorer\Main\'

$name = 'start page'

$value = 'http://blogs.technet.com/b/heyscriptingguy/'

Clear
Set-Itemproperty -Path $path -Name $name -Value $value


Get-IEStartPage 


$path = 'HKCU:\Software\Microsoft\Internet Explorer\Main\'

$name = 'start page'

(Get-Itemproperty -Path $path -Name $name).$name


