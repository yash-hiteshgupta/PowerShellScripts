﻿$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key HideFileExt 1
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key ShowSuperHidden 1
Stop-Process -processname explorer
