@echo off
for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\path.txt') do set path=%%a
for /f "delims=" %%a in ('type %path%\config\executableVersion.txt') do set version=%%a
for /f "delims=" %%a in ('type %path%\config\version.txt') do set installed=%%a
set /p user=<%path%\config\user.txt
set /p repo=<%path%\config\repository.txt
set "dir=%cd%"
REM safe / keep enable / disable

if "%1"=="--enable" (
   if "%2"=="safe" (
      type nul > %path%\safe.txt
      echo Safe Mode succesfully enabled!
   )
   if "%2"=="keep" (
      type nul > %path%\keep.txt
      echo Temp Suppressing succesfully enabled!
   )
)
cd %dir%
if "%1"=="--disable" (
   if "%2"=="safe" (
      if exist "%path%\safe.txt" (
         del /Q %path%\safe.txt
         echo Safe Mode succesfully disabled!
      ) else (
         echo Safe Mode was already disabled! 
      )
   )
   if "%2"=="keep" (
      if exist "%path%\keep.txt" (
         del /Q %path%\keep.txt
         echo Temp Suppressing succesfully disabled!
      ) else (
         echo Temp Suppressing was already disabled! 
      )
      
   )
)
cd %dir%

REM Execute

if "%1"=="--execute" (
   if exist "%path%\%2.bat" (
   cd %path%
   call "%path%\%2.bat"
   cd %dir%
   ) else (
      echo Invalid argument. Use --execute to run a specific existent file.
   )
)

if "%1"=="--ec" (
   if exist "%path%\%2.bat" (
   cd %path%
   call "%path%\%2.bat"
   cd %dir%
   ) else (
      echo Invalid argument. Use --execute to run a specific existent file.
   )
)
cd %dir%

REM Update

if "%1"=="--update" (
   if "%2"=="auto" (
   call "%path%\updateComponents\getUpdate.bat" > null 2>&1
   call "%path%\updateComponents\update.bat" %3
   ) else (
   echo This will download RemExec and install it! [~3 MB]
   echo ==================================================
   pause
   echo Downloading Update...
   call "%path%\updateComponents\getUpdate.bat" > null 2>&1
   call "%path%\updateComponents\update.bat" %3
   )
)
cd %dir%

REM Configure

if "%1"=="--config" (
   type %path%\config\%2.txt
   echo \/
   echo %3> %path%\config\%2.txt
   type %path%\config\%2.txt
)
cd %dir%

REM version

if "%1"=="--v" (
   type %path%\config\version.txt
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
   xcopy /Y /Q "%path%\%2" "C:\Windows"
)
cd %dir%

REM Features
if "%1"=="--extension" (
   if "%3"=="--install" (
      cd %path%
      call git clone https://github.com/%user%/extension-%2.git >nul 2>&1
      remote --add extension-%2\*
      rmdir /s /q extension-%2
      echo installed> %path%\config\extension-%2.txt
      cd %dir%
   ) else (
   if exist %path%\config\extension-%2.txt (
      for /f "delims=" %%a in ('type %path%\config\extension-%2.txt') do set feat-%2=%%a
      echo %feat-%2%
      cd %dir%
   ) else (
      echo The extension : %2 isn't installed!
   )
)
)


cd %dir%