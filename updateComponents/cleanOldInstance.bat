@echo off
for /f "delims=" %%a in ('type ..\config\version.txt') do set installed=%%a
for /f "delims=" %%a in ('type ..\config\executableVersion.txt') do set ECV=%%a
echo Saved Configs:
echo ..\config\version.txt = %installed%
echo ..\config\executableVersion.txt = %ECV%
pause
echo Erasing...
call rmdir /s %localappdata%\Programs\RemExec >nul 2>&1
echo Restoring Config data...
mkdir %localappdata%\Programs\RemExec\config
echo %installed% > %localappdata%\Programs\RemExec\config\version.txt
echo %ECV% >  %localappdata%\Programs\RemExec\config\executableVersion.txt
echo Waiting Remote to respond...
remote --verify
set "exit_code=%ERRORLEVEL%"
if %exit_code% equ 20 (
    echo Remote responded with: %exit_code%
    echo Root Folder now is clean!
) else (
    echo Remote failed to respond!
    echo Reinstall the program! or do remote --restore
)
pause