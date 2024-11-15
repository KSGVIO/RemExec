@echo off
for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\executableVersion.txt') do set version=%%a
for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\version.txt') do set installed=%%a
set /p user=<%localappdata%\Programs\RemExec\config\user.txt
set /p repo=<%localappdata%\Programs\RemExec\config\repository.txt
set "dir=%cd%"
REM safe / keep enable / disable

if "%1"=="--enable" (
   if "%2"=="safe" (
      type nul > %localappdata%\Programs\RemExec\safe.txt
      echo Safe Mode succesfully enabled!
   )
   if "%2"=="keep" (
      type nul > %localappdata%\Programs\RemExec\keep.txt
      echo Temp Suppressing succesfully enabled!
   )
)
cd %dir%
if "%1"=="--disable" (
   if "%2"=="safe" (
      if exist "%localappdata%\Programs\RemExec\safe.txt" (
         del /Q %localappdata%\Programs\RemExec\safe.txt
         echo Safe Mode succesfully disabled!
      ) else (
         echo Safe Mode was already disabled! 
      )
   )
   if "%2"=="keep" (
      if exist "%localappdata%\Programs\RemExec\keep.txt" (
         del /Q %localappdata%\Programs\RemExec\keep.txt
         echo Temp Suppressing succesfully disabled!
      ) else (
         echo Temp Suppressing was already disabled! 
      )
      
   )
)
cd %dir%

REM Execute

if "%1"=="--execute" (
   if exist "%localappdata%\Programs\RemExec\%2.bat" (
   cd %localappdata%\Programs\RemExec
   call "%localappdata%\Programs\RemExec\%2.bat"
   cd %dir%
   ) else (
      echo Invalid argument. Use --execute to run a specific existent file.
   )
)

if "%1"=="--ec" (
   if exist "%localappdata%\Programs\RemExec\%2.bat" (
   cd %localappdata%\Programs\RemExec
   call "%localappdata%\Programs\RemExec\%2.bat"
   cd %dir%
   ) else (
      echo Invalid argument. Use --execute to run a specific existent file.
   )
)
cd %dir%

REM Update

if "%1"=="--update" (
   if "%2"=="auto" (
   call "%localappdata%\Programs\RemExec\updateComponents\getUpdate.bat" > null 2>&1
   call "%localappdata%\Programs\RemExec\updateComponents\update.bat" %3
   ) else (
   echo This will download RemExec and install it! [~3 MB]
   echo ==================================================
   pause
   echo Downloading Update...
   call "%localappdata%\Programs\RemExec\updateComponents\getUpdate.bat" > null 2>&1
   call "%localappdata%\Programs\RemExec\updateComponents\update.bat" %3
   )
)
cd %dir%

REM Configure

if "%1"=="--config" (
   type %localappdata%\Programs\RemExec\config\%2.txt
   echo \/
   echo %3> %localappdata%\Programs\RemExec\config\%2.txt
   type %localappdata%\Programs\RemExec\config\%2.txt
)
cd %dir%

REM version

if "%1"=="--v" (
   type %localappdata%\Programs\RemExec\config\version.txt
)
cd %dir%
if "%1"=="--fv" (
   echo RemExec X Remote installed version: %installed% - %version%
)
cd %dir%

REM ez update
if "%1"=="--UAI" (
   remote --config version 1.0
   remote --update auto --updateInstaller
)
if "%1"=="--UA" (
   remote --config version 1.0
   remote --update auto
)
if "%1"=="--U" (
   remote --update
)


REM src

if "%1"=="--src" (
   type C:\Windows\remote.bat
)

REM Add files to C:\windows
if "%1"=="--add" (
   xcopy /Y /Q "%localappdata%\Programs\RemExec\%2" "C:\Windows"
)
cd %dir%

REM Features
if "%1"=="--extension" (
   if "%3"=="--install" (
      cd %localappdata%\Programs\RemExec
      call git clone https://github.com/%user%/extension-%2.git >nul 2>&1
      remote --add extension-%2\*
      rmdir /s /q extension-%2
      echo installed> %localappdata%\Programs\RemExec\config\extension-%2.txt
      cd %dir%
   ) else (
   if exist %localappdata%\Programs\RemExec\config\extension-%2.txt (
      for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\extension-%2.txt') do set feat-%2=%%a
      echo %feat-%2%
      cd %dir%
   ) else (
      echo The extension : %2 isn't installed!
   )
)
)


REM Clean old instance

if "%1"=="--clean" (
   echo This will erase everything and will commit a CLEAN install!
   pause
   call %localappdata%\Programs\RemExec\updateComponents\cleanOldInstance.bat
)

REM respond
if "%1"=="--verify" (
   exit /b 20
)

REM Restore
if "%1"=="--restore" (
   rmdir /s %localappdata%\Programs\RemExec
   cd %localappdata%\Programs
   git clone https://github.com/KSGVIO/RemExec
)

REM repair
if "%1"=="--rrv" (
   cd %localappdata%\Programs
   call git clone https://github.com/KSGVIO/RemExec> null 2>&1
   cd RemExec
   start elevate.bat


cd %dir%