@echo off
for /F "tokens=*" %%g IN ('where git') do (SET git=%%g)

if "%git%"=="C:\Program Files\Git\cmd\git.exe" (
   cd %localappdata%\Programs\RemExec
   start /min fetch.bat
   exit
) else (
   exit
)
