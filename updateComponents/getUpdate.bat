@echo off
cd %localappdata%\Programs\RemExec\updateComponents
git clone https://github.com/KSGVIO/RemExec.git

if "%1"=="-exit" (
   exit 
)