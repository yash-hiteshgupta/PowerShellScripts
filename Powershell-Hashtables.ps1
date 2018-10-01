clear
$hash = @{ ID = 1; Shape = "Square"; Color = "Blue"}
$hash
echo ""
echo "Individual values"
$hash["ID"]
$hash["Shape"]
$hash["Color"]

echo ""
echo "Keys only"
$hash.keys
echo ""
echo "Values only"
$hash.values

echo ""
write-host("Get Shape")
$hash.Number

echo ""
write-host("print Size")
$hash.Count

echo ""
write-host("Update key-value")
$hash["Updated"] = "Now"
$hash

echo ""
write-host("Add key-value")
$hash.Add("Created","Now")
$hash

echo ""
write-host("print Size")
$hash.Count

echo ""
write-host("Remove key-value")
$hash.Remove("Updated")
$hash

echo ""
write-host("print Size")
$hash.Count

echo ""
write-host("sort by key")
$hash.GetEnumerator() | Sort-Object -Property key
