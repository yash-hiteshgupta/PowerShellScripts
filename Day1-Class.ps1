<#
Date    : 28-09-2018
Created By: Hitesh Gupta
Description: Sample code for implement for:
              - namespace
              - class
              - methods
              - enum
              - ref
              - Property
#>

clear
$code = @"
using System;
namespace Mathematics
{
 public class Operation
 {
    private string code = "Hitesh Gupta";
    public string MyProperty{
        get {
            return code;
         }
         set {
            code = value;
         }
    }
    
    public enum EMethod
    {
        Add,
        Substract,
        Multiply,
        Devide
    }
    
    public void ShowProperty()
    {
        Console.WriteLine(MyProperty);
    }
    
    public static int Addition(int x, int y, int result)
    {
        result = x + y;
        return x + y;
    }
    public void Substraction(int x, int y, out int result)
    {
        result = x - y;
    }
    
    public int ChooseCalculation(EMethod calc, int value1, int value2)
    {
        switch(calc)
        {
            case EMethod.Add:
                return value1 + value2;
            case EMethod.Substract:
                return value1 - value2;
            case EMethod.Multiply:
                return value1 * value2;
            case EMethod.Devide:
                return value1 / value2;
                
        }
        return 0;
    }
 }
}
"@if (([System.Management.Automation.PSTypeName]'Mathematics.Operation').Type)
{
 #Remove-Type -TypeDefinition $code -Language CSharp;
}else{
Add-Type -TypeDefinition $code -Language CSharp;
}
echo "# Excute static method directly"
[Mathematics.Operation]::Addition(1,2,$output);
$output
echo "# Object instantiation"
$instance = New-Object Mathematics.Operation;
[int]$result = 0
$instance.Substraction(7,5,[ref] $result);
$result
echo `n
$instance.ChooseCalculation("Add",7,5);$instance.ChooseCalculation("Substract",7,5);$instance.ChooseCalculation("Multiply",7,5);$instance.ChooseCalculation("Devide",7,5);
$instance.ShowProperty();

