@echo off
set "dir=%cd%"
for /F "tokens=*" %%g IN ('where git') do (SET git=%%g)
for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\path.txt') do set path=%%a
cd %path%
if "%git%"=="C:\Program Files\Git\cmd\git.exe" (
   start /min fetch.bat
   exit
   ) else (
   start /WAIT abort.vbs
   exit
)
cd %dir%