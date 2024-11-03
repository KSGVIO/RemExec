@echo off
set /p=%cd%
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

REM Execute

if "%1"=="--execute" (
   if exist "%localappdata%\Programs\RemExec\%2.bat" (
   cd %localappdata%\Programs\RemExec
   call "%localappdata%\Programs\RemExec\%2.bat"
   cd ..
   ) else (
      echo Invalid argument. Use --execute to run a specific existent file.
   )
)

REM Update

if "%1"=="--update" (
   if "%1"=="auto" (
   call "%localappdata%\Programs\RemExec\updateComponents\getUpdate.bat" > null 2>&1
   call "%localappdata%\Programs\RemExec\updateComponents\update.bat"
   ) else (
   echo This will download RemExec and install it! [~3 MB]
   echo ==================================================
   pause
   echo Downloading Update...
   call "%localappdata%\Programs\RemExec\updateComponents\getUpdate.bat" > null 2>&1
   call "%localappdata%\Programs\RemExec\updateComponents\update.bat"
   )
)

REM Configure

if "%1"=="--config" (
   type %localappdata%\Programs\RemExec\config\%2.txt
   echo \/
   echo %3 > %localappdata%\Programs\RemExec\config\%2.txt
   type %localappdata%\Programs\RemExec\config\%2.txt
)

REM version

if "%1"=="--v" (
   type %localappdata%\Programs\RemExec\config\version.txt
)

cd %cd%