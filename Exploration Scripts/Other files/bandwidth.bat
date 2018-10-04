@echo off
color 0b
MODE CON:COLS=16 LINES=5
title TCP Graph 30kb Max
:begin
for /F "tokens=10 delims=ms=," %%a in ('ping -n 1 -w 10000 -l 1024 8.8.8.8^| find "Average"') do set "P1=%%a"
netstat -e | find "Bytes" >NUL
for /F "tokens=2,3" %%a in ('netstat -e ^| find "Bytes"') do set "received1=%%a" & set "sent1=%%b"
netstat -e | find "Bytes" >NUL
for /F "tokens=2,3" %%a in ('netstat -e ^| find "Bytes"') do set "received2=%%a" & set "sent2=%%b"
set /a r1=%received1%
set /a r2=%received2%
set /a s1=%sent1%
set /a s2=%sent2%
set /a q1=%r2%-%r1%
set /a a1=%q1%
set /a q2=%s2%-%s1%
set /a a2=%q2%
set /a q3=%a1%+%a2%
set /a a3=%q3%
set /a q4=%a3%/1024
set /a a4=%q4%
if %a3% gtr 0 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo. )
if %a3% gtr 2048 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo *              )
if %a3% gtr 4096 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo **             )
if %a3% gtr 6144 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo ***            )
if %a3% gtr 8192 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo ****           )
if %a3% gtr 10240 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo *****          )
if %a3% gtr 12288 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo ******         )
if %a3% gtr 14336 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo *******        )
if %a3% gtr 16384 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo ********       )
if %a3% gtr 18432 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo *********      )
if %a3% gtr 20480 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo **********     )
if %a3% gtr 22528 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo ***********    )
if %a3% gtr 24576 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo ************   )
if %a3% gtr 26624 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo *************  )
if %a3% gtr 28672 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo ************** )
if %a3% gtr 30720 ( echo BANDWIDTH STATUS & echo      %a4% kb/s  & echo ***************)
goto begin