@echo off
for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\path.txt') do set path=%%a
for /F "tokens=*" %%g IN ('where git') do (SET git=%%g)
if "%git%"=="C:\Program Files\Git\cmd\git.exe" (
   goto create
) else (
   start /WAIT abort.vbs
   exit
)

:create
schtasks /Create /TR "%path%\task.bat" /RU %USERNAME% /TN Fetch /SC ONLOGON /f
if "%1"=="--update" (
   call %path%\killall.bat
   exit
)
schtasks /Run /TN "Fetch"
exit