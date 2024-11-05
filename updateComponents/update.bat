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
) else (
   xcopy "RemExec\*" "..\." /s /e /y > nul
   rmdir /s /q "RemExec"
   cd %localappdata%\Programs\RemExec
   wmic process where "name='WMIC.exe'" get parentprocessid > .\updateComponents\PID.txt
   type .\updateComponents\PID.txt | findstr /V "ParentProcessId" > .\updateComponents\PID.txt
   del /q "elevate.bat"
   del /q "README.md"
   del /q ".gitattributes"
   echo Update installed!
   echo -Configured version was updated from %installed% to %carrying%
   echo %carrying%> config\version.txt
   echo ======================================================= 
   echo The installer need to replace main executable and will kill this window!
   pause
   start .\updateComponents\updateExecutable.bat
   exit
)

