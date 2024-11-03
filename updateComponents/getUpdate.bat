@echo off
cd %localappdata%\Programs\RemExec\updateComponents
git clone https://github.com/KSGVIO/RemExec.git
call update.bat >nul 2>&1

if "%1"=="-exit" (
   exit 
)