<#
Date    :    23-10-2018
Created By:  Hitesh Gupta
Description: Sample code for demonstrate Inheritance using PowerShell
#>
        
enum MakeOfCar {
    Chevy = 1
    Ford = 2
    Olds = 3
    Toyota = 4
    BMW = 5
}

enum ColorOfCar {
    Red = 1
    Blue = 2
    Green = 3
}  
class Vehicle {
    [string]$Year
    [string]$Model
          
    }

class Car : Vehicle {
    [string]$Vin
    [MakeOfCar]$Make
    [ColorOfCar]$Color
}


clear
$a = [Car]::new();
$a.Color = 1 ; $a.Make = 2 ; $a.Model = "mustang" ; $a.Vin = 12345 ; $a.Year = "01/10/2018";
$a
#$a | Get-Member -MemberType Property