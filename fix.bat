@echo off
if "%1"=="--rrv" (
   echo Fixing RemExec...
   cd %localappdata%\Programs
   call git clone https://github.com/KSGVIO/RemExec> null 2>&1
   cd RemExec
   start elevate.bat --update
)