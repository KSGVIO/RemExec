@echo off

REM Check for Compilers
if not exist "C:\Cargo\compile.bat" (
   call "%localappdata%\Programs\RemExec\nocargo.vbs"
   exit /b
) else if not exist "C:\SLN\compile.bat" (
   call "%localappdata%\Programs\RemExec\nosln.vbs"
   exit /b
)

REM Check arguments for --useCargo or --useSLN
if "%2"=="--useCargo" (
   shift
   shift
   call "C:\Cargo\compile.bat" %*
) else if "%2"=="--useSLN" (
   shift
   shift
   call "C:\SLN\compile.bat" %*
) else (
   exit /b
)
