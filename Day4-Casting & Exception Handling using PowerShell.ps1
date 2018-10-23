enum Operator {
    EQUAL = 1
    GREATER_THAN = 2
    LESS_THAN = 3
}
class Casting {

    IsValid([string]$inputString, [string]$checkString, [int]$operation) {         
        try{
                $result = $this.Comparision($inputString, $checkString, $operation)

                Write-Host "Result : $result"
        }
        catch
        {
            
        }
    }

    [bool] Comparision([double]$obj1, [double]$obj2, [Operator]$operation) {
        Write-Host "Value 1 : $obj1"
        Write-Host "Value 2 : $obj2"
        Write-Host "Operation : $operation"
        switch ($operation) {
            EQUAL {
                    return $obj1.Equals($obj2)
                }
            GREATER_THAN {
                    return $obj1.CompareTo($obj2) -gt 0
                }
            LESS_THAN {                    
                    return $obj1.CompareTo($obj2) -lt 0
                }
            default {
                    return False                   
                }                
        }
        return False
    }
}

clear
$a = [Casting]::new();
$a.IsValid(10,11,3)

