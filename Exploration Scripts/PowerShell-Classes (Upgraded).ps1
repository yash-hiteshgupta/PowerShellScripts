clear
Class Vehicle
{
    [datetime]$Year
    [string]$Model
    [int]$Make
    [string]$Color
}

Class Car : Vehicle
{
 [string]$Vin
}

$rack = [Car]::new()
$rack.Color = "Red";
$rack.Make = 2; 
$rack.Model = "mustang"; 
$rack.Vin = 12345; 
$rack.Year = "01/10/2018";
$rack