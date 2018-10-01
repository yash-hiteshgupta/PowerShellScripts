clear
echo "########### measure-object"
get-content "D:\Hitesh Gupta\Scripts\test.ps1" | measure-object -character -line -word

echo "########### get-unique"
$list = 2,2,3,5,4,1
echo "List:"$list
echo "Result list:"$list | sort | get-unique

clear
echo "########### Compare-Object (only differ content)"
Compare-Object -ReferenceObject $(Get-Content "D:\Hitesh Gupta\Scripts\test1.ps1") -DifferenceObject $(Get-Content "D:\Hitesh Gupta\Scripts\test.ps1")
echo "########### Compare-Object (including similar content)"
Compare-Object -ReferenceObject $(Get-Content "D:\Hitesh Gupta\Scripts\test1.ps1") -DifferenceObject $(Get-Content "D:\Hitesh Gupta\Scripts\test.ps1") -IncludeEqual

clear
echo "########### Format-List"
$A = Get-ChildItem "D:\Hitesh Gupta\Scripts\test.ps1"
Format-List -InputObject $A
