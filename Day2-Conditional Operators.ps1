<#
Date    :    28-09-2018
Created By:  Hitesh Gupta
Description: Sample code for demonstrate Operators
#>

clear
$a = 10
$b = 20
$c = 25
$d = 25
$e = 30

echo "Operators example:"echo ""
if($a -lt $b){
   write-host("$a < $b is true")
}else {
   write-host("$a < $b is false")
}
if($c -le $d){
   write-host("$c <= $d is true")
}else {
   write-host("$c <= $d is false")
}
if($a -ge $b){
   write-host("$a > $b is true")
}else {
   write-host("$a > $b is false")
}

echo ""
echo "Compare A, B and C:"
if($a -lt $b)
{
    if($a -lt $c)
    {
        echo ("A is smallest");    
    }
    else
    {
        echo ("C is smallest");
    }
}
elseif($b -lt $c)
{
    echo ("B is smallest");    
}
else
{
    echo ("C is smallest");
}

echo ""
echo "Switch example:"switch($b,$a,$e) {
   10 {"value 10"}
   20 {"value 20"}
   30 {"value 30"}
   40 {"value 40"}
   30 {"value 30 Again"}
}