<#
REFERENCES: 
1. https://stackoverflow.com/questions/45756791/install-software-using-powershell-script
2. http://www.techken.in/windows/powershell-script-install-uninstall-software/
3. https://community.spiceworks.com/topic/1964881-enable-ie-add-on-for-all-users-powershell
4. https://social.technet.microsoft.com/Forums/ie/en-US/a22f4113-55d9-4f1a-ab1d-71801129d702/deactivate-addons-by-start-ie-with-powershell-for-automated-tests?forum=ITCG

#>

# Script 1:

Start-Process 'D:\npp.7.5.9.Installer.exe' "/S"


# Script 2 (For Remote Machines):

$computers = c:\temp\computerName.csv
$Notepad = "Location of notepad install"

$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object {

  copy-item $Notepad -recurse "\\$_\c$\temp" 

  $newProc=([WMICLASS]"\\$_\root\cimv2:win32_Process").Create("D:\npp.7.5.9.Installer.exe /S")

  If ($newProc.ReturnValue -eq 0) { 
    Write-Host $_ $newProc.ProcessId 
  } else { 
    write-host $_ Process create failed with $newProc.ReturnValue 
  }
}
