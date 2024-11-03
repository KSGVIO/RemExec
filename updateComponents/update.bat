@echo off
cd %localappdata%\Programs\RemExec\updateComponents

for /f "delims=" %%a in ('type ..\config\version.txt') do set installed=%%a
for /f "delims=" %%a in ('type RemExec\config\version.txt') do set carrying=%%a

echo Installed version: "%installed%"
echo Carrying version: "%carrying%"


if "%installed%" GEQ "%carrying%" (
   echo %installed%  %carrying% a better/same version is installed
   echo Cleaning downloaded files...
   rmdir /s /q "RemExec"
) else (
   xcopy "RemExec\*" "..\." /s /e /y
   rmdir /s /q "RemExec"
   cd %localappdata%\Programs\RemExec
   del /q elevate.bat
   del /q README.md
   del /q .gitattributes
   echo %carrying% > config\version.txt
)
if "%1"=="-exit" (
   exit
)