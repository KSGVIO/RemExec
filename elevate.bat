@echo off
echo ============================
echo Moded version of UAC (RemExec Injector)
echo ============================
set "dir=%cd%"
:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 rem this works also from cmd shell, other than %~0
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else (
    goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  if '%cmdInvoke%'=='1' goto InvokeCmd 
  

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation

 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*

 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
 

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::

 cls
 net session >nul 2>&1
if %errorLevel% == 0 (
   cd %localappdata%\Programs\RemExec
   del /Y C:\Windows\remote.bat
   move /Y remote.bat "C:\Windows"
   start /min %localappdata%\Programs\RemExec\create.bat %1
   del /q README.md
   del /q .gitattributes
   remote --add elevate.bat
   remote --add admin.bat
   remote --add compile.bat
   remote --add fix.bat
   if "%1"=="--update" (
      remote --appendLocal
   )
   exit
) else (
   exit
)
