<#
Date    :    01-10-2018
Created By:  Hitesh Gupta
Description: Sample code for demonstrate Inheritance
#>

clear
$code = @"
using System;
namespace Inheritance
{
    public class Vehicle
    {
        public string Year;
        public string Model;
        
        
        public enum MakeOfCar
        {
            Chevy = 1,
            Ford = 2,
            Olds = 3,
            Toyota = 4,
            BMW = 5
        }

        public enum ColorOfCar
        {
            Red = 1,
            Blue = 2,
            Green = 3
        }    
     }

    public class Car : Vehicle
    {
     public string Vin;
     public MakeOfCar Make;
     public ColorOfCar Color;
    }

}
"@if (-not ([System.Management.Automation.PSTypeName]'Inheritance.Car').Type)
{
 Add-Type -TypeDefinition $code -Language CSharp;
}
$a = New-Object Inheritance.Car;
$a.Color = 1 ; $a.Make = 2 ; $a.Model = "mustang" ; $a.Vin = 12345 ; $a.Year = "01/10/2018";
$a
#$a | Get-Member -MemberType Property