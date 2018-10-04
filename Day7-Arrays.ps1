clear
echo "Array example:"
[int32[]]$intA = 1500,2230,3350,4000

$A = 1, 2, 3, 4
$A.getType()

clear
$myList = 5.6, 4.5, 3.3, 13.2, 4.0, 34.33, 34.0, 45.45, 99.993, 11123

echo ""
write-host("Print all the array elements")
$myList

echo ""
write-host("Get the length of array:")
$myList.Length

echo ""
write-host("Get Second element of array:")
$myList[1]

echo ""
write-host("Get partial array:")
$subList = $myList[1..3]

echo ""
write-host("print subList")
$subList

echo ""
write-host("using for loop:")
for ($i = 0; $i -lt $myList.length; $i += 1) {
  $myList[$i]
}

echo ""
write-host("using forEach Loop:")
foreach ($element in $myList) {
  $element
}

echo ""
write-host("using while Loop:")
$i = 0
while($i -le 4) {
  $myList[$i];
  $i++
}
