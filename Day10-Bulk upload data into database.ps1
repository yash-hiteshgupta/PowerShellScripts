<#
Date    : 11-10-2018
Created By: Hitesh Gupta
Description: Sample code to connect with database and write bulk data.
#>

clear
echo "# Connecting with Sql Server"
$SQLServer = "YI1008339DT\SQLEXPRESS"
$SQLDBName = "PowerShell"
$uid ="sa"
$pwd = "yash@123"

$hash = @(
            @{ID = 1; Name = "User A"; PhoneNumber = "2222222"; EmailAddress = "UserA@gmail.com"},
            @{ID = 2; Name = "User B"; PhoneNumber = "3333333"; EmailAddress = "UserB@gmail.com"}
        )

####  Loop for insert record
Try
{
    foreach ($element in $hash) { 
        $insertquery=" 
                    INSERT INTO [dbo].[Student] 
                               ([Id] 
                               ,[Name] 
                               ,[PhoneNumber] 
                               ,[EmailAddress]) 
                         VALUES 
                               (NEWID()
                               ,'"+$element.Name+"' 
                               ,'"+$element.PhoneNumber+"' 
                               ,'"+$element.EmailAddress+"') 
                    GO 
                    " 
        Invoke-SQLcmd -ServerInstance $SQLServer -query $insertquery -U $uid -P $pwd -Database $SQLDBName 
    }
}
Catch
{
    Throw "Some error occured."
}


