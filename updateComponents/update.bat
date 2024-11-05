@echo off
set "dir=%cd%"
cd "%localappdata%\Programs\RemExec\updateComponents"

if not exist "..\config\version.txt" (
   echo Version file not found: ..\config\version.txt
   exit /b 1
)

if not exist "RemExec\config\version.txt" (
   echo Version file not found: RemExec\config\version.txt
   exit /b 1
)

for /f "delims=" %%a in ('type ..\config\version.txt') do set installed=%%a
for /f "delims=" %%a in ('type RemExec\config\version.txt') do set carrying=%%a

echo Installed version: "%installed%"
echo Carrying version: "%carrying%"

if "%installed%" GEQ "%carrying%" (
   echo %installed%  %carrying% a better/same version is installed
   echo Cleaning downloaded files...
   rmdir /s /q "RemExec"
   cd %dir%
) else (
   xcopy "RemExec\*" "..\." /s /e /y > nul
   rmdir /s /q "RemExec"
   cd %localappdata%\Programs\RemExec
   del /q "README.md"
   del /q ".gitattributes"
   echo Update installed!
   echo -Configured version was updated from %installed% to %carrying%
   echo %carrying%> config\version.txt
   if "%1"=="--updateInstaller" (
   echo ======================================================= 
   echo The installer need to replace main executable and will kill this window!
   pause
   start .\elevate.bat
   cd %dir%
   exit
   )
)

