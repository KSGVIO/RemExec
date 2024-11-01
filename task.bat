@echo off
for /F "tokens=*" %%g IN ('where git') do (SET git=%%g)
cd %localappdata%\Programs\RemExec
if "%git%"=="C:\Program Files\Git\cmd\git.exe" (
   start /min fetch.bat
   exit
) else (
   start /WAIT abort.vbs
   exit
)
