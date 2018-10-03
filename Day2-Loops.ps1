<#
Date    :    28-09-2018
Created By:  Hitesh Gupta
Description: Sample code for demonstrate Loops
#>

clear
echo ""
echo "########### for loop"
$array = @("for1", "for2", "for3")
for($i = 0; $i -lt $array.length; $i++){ $array[$i] }

echo ""
echo "########### foreach loop"
$array = @("foreach1", "foreach2", "foreach3") 
foreach ($element in $array) { $element }
 
echo ""
echo "########### foreach loop (second way)"
$array | foreach { $_ }

echo ""
echo "########### WHILE LOOP"
$array = @("While1", "While2", "While3")
$counter = 0;
while($counter -lt $array.length){
   $array[$counter]
   $counter += 1
}

echo ""
echo "########### DO..WHILE LOOP"
$array = @("dowhile1", "dowhile2", "dowhile3")
$counter = 0;
do {
   $array[$counter]
   $counter += 1
} while($counter -lt $array.length)

