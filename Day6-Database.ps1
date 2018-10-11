<#
Date    : 05-10-2018
Created By: Hitesh Gupta
Description: Sample code to connect with database.
#>

clear
echo "# Connecting with Sql Server"
$SQLServer = "YI1008339DT\SQLEXPRESS"
$SQLDBName = "PowerShell"
$uid ="sa"
$pwd = "yash@123"
$SqlQuery = "SELECT * from [Student];"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = False; User ID = $uid; Password = $pwd;"
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)

$DataSet.Tables[0] | out-file "D:\Hitesh Gupta\Students.xls"


echo "# Connecting with Access"

$OpenStatic = 3
$LockOptimistic = 3
$connection = New-Object -ComObject ADODB.Connection
$connection.Open("Provider = Microsoft.Jet.OLEDB.4.0;Data Source=$Db" )


Function Check-Path($Db)
{
 If(!(Test-Path -path (Split-Path -path $Db -parent)))
   { 
     Throw "$(Split-Path -path $Db -parent) Does not Exist" 
   }
  ELSE
  { 
   If(!(Test-Path -Path $Db))
     {
      Throw "$db does not exist"
     }
  }
} #End Check-Path

Function Get-Bios
{
 Get-WmiObject -Class Win32_Bios
} #End Get-Bios

Function Get-Video
{
 Get-WmiObject -Class Win32_VideoController
} #End Get-Video

Function Connect-Database($Db, $Tables)
{
  $OpenStatic = 3
  $LockOptimistic = 3
  $connection = New-Object -ComObject ADODB.Connection
  $connection.Open("Provider = Microsoft.Jet.OLEDB.4.0;Data Source=$Db" )
  Update-Records($Tables)
} #End Connect-DataBase

Function Update-Records($Tables)
{
  $RecordSet = new-object -ComObject ADODB.Recordset
   ForEach($Table in $Tables)
     {
      $Query = "Select * from $Table"
      $RecordSet.Open($Query, $Connection, $OpenStatic, $LockOptimistic)
      Invoke-Expression "Update-$Table"
      $RecordSet.Close()
     }
   $connection.Close()
} #End Update-Records

Function Update-Bios
{
 "Updating Bios"
 $BiosInfo = Get-Bios

 $RecordSet.AddNew()
 $RecordSet.Fields.Item("DateRun") = Get-Date
 $RecordSet.Fields.Item("Manufacturer") = $BiosInfo.Manufacturer
 $RecordSet.Fields.Item("SerialNumber") = $BiosInfo.SerialNumber
 $RecordSet.Fields.Item("SMBIOSBIOSVersion") = $BiosInfo.SMBIOSBIOSVersion
 $RecordSet.Fields.Item("Version") = $BiosInfo.Version
 $RecordSet.Update()
} #End Update-Bios

Function Update-Video
{
 "Updating video"
 $VideoInformation = Get-Video
 Foreach($VideoInfo in $VideoInformation)
  { 
   $RecordSet.AddNew()
   $RecordSet.Fields.Item("DateRun") = Get-Date
   $RecordSet.Fields.Item("AdapterCompatibility") = $VideoInfo.AdapterCompatibility
   $RecordSet.Fields.Item("AdapterDACType") = $VideoInfo.AdapterDACType
   $RecordSet.Fields.Item("AdapterRAM") = $VideoInfo.AdapterRAM
   $RecordSet.Fields.Item("Description") = $VideoInfo.Description
   $RecordSet.Fields.Item("DriverDate") = $VideoInfo.DriverDate
   $RecordSet.Fields.Item("DriverVersion") = $VideoInfo.DriverVersion
   $RecordSet.Update()
  }
} #End Update-Video

# *** Entry Point to Script ***

$Db = "C:\Users\hitesh.gupta\Downloads\AC101\Test.mdb"
$Tables = "Standard Jet DB"
Check-Path -db $Db
Connect-DataBase -db $Db -tables $Tables

