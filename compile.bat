@echo off
REM check Compilers
if exist "C:\Cargo\compile.bat" (
   %localappdata%\Programs\RemExec\nocargo.vbs
   exit
) else if exist "C:\SLN\compile.bat"(
   %localappdata%\Programs\RemExec\nosln.vbs
   exit
)
if "%2"=="--useCargo" (
   shift
   shift
   C:\Cargo\compile.bat %*
) else if "%2"=="--useSLN"(
   shift
   shift
   C:\SLN\compile.bat %*
)