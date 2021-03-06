<#
Date    :    01-10-2018
Created By:  Hitesh Gupta
Description: Sample code for demonstrate Casting & Exception Handling using c#
#>

clear
$code = @"
using System;
namespace PowerShell
{
    public enum Operator
    {
        EQUAL = 1,
        GREATER_THAN = 2,
        LESS_THAN = 3
    }
    public class Casting
    {
        public bool isValid(string inputString, string checkString, int value)     
        {         
            try
            {
                Operator operation = (Operator)value;
                
                double dblTmp1;
                double dblTmp2;

                if (Double.TryParse(inputString, out dblTmp1) && Double.TryParse(checkString, out dblTmp2))
                {
                    return Compare<Double>(dblTmp1, dblTmp2, operation);
                }

                DateTime dtTmp1;
                DateTime dtTmp2;
                if (DateTime.TryParse(inputString, out dtTmp1) && DateTime.TryParse(checkString, out dtTmp2))
                {
                    return Compare<DateTime>(dtTmp1, dtTmp2, operation);
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine("Exception:" + ex.Message);
            }
            return false;
        }

        public static bool Compare<T>(T obj1, T obj2, Operator operation) where T : IComparable      
        {
            Console.WriteLine("Value 1:"+ obj1);
            Console.WriteLine("Value 2:"+ obj2);
            switch (operation)
            {
                case Operator.EQUAL:
                    {
                        return obj1.Equals(obj2);
                    }
                case Operator.GREATER_THAN:
                    {
                        return obj1.CompareTo(obj2) > 0;
                    }
                case Operator.LESS_THAN:
                    {
                        return obj1.CompareTo(obj2) < 0;
                    }
                default:
                    {
                        throw new InvalidOperationException("Unknown operation");
                    }
            }
        }
    }

}
"@
if (-not ([System.Management.Automation.PSTypeName]'PowerShell.Casting').Type)
{
 Add-Type -TypeDefinition $code -Language CSharp;
}
ECHO "EQUAL = 1, `nGREATER_THAN = 2,`nLESS_THAN = 3`n`n"
$a = New-Object PowerShell.Casting;
$a.isValid(10,11,3)
