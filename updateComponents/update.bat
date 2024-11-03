@echo off
cd %localappdata%\Programs\RemExec\updateComponents
for /f "delims=" %%a in ('type ..\config\version.txt') do set installed=%%a
for /f "delims=" %%a in ('type ..\Payloads\updateComponents\version.txt') do set carrying=%%a

echo Installed version: "%installed%"
echo Carrying version: "%carrying%"

if "%installed%" GEQ "%carrying%" (
   pause
   exit
) else (
   cd %localappdata%\Programs\RemExec
   git clone https://github.com/KSGVIO/RemExec.git
   xcopy "RemExec\*" "." /s /e /y
   rmdir /s /q "RemExec"
   del /q elevate.bat
   del /q README.md
   del /q .gitattributes
   echo %carrying% > config\version.txt
   pause
   exit

)