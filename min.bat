@echo off
REM Save the current directory path
set "original_dir=%cd%"

REM Find the Git executable path
for /F "tokens=*" %%g IN ('where git 2^>nul') do set "git_path=%%g"
set "config_path=%localappdata%\Programs\RemExec\config\path.txt"

REM Check if Git is found; exit if not
if not defined git_path (
    start /WAIT abort.vbs
    exit /b
)

REM Read the target directory from path.txt, with error handling

if not exist "%config_path%" (
    echo Configuration file not found at "%config_path%".
    exit /b
)

for /f "delims=" %%a in ('type "%config_path%"') do set "target_dir=%%a"
REM Check if the directory in path.txt exists; exit if not
if not exist "%target_dir%" (
    echo Target directory "%target_dir%" does not exist.
    exit /b
)

REM Change to the target directory
cd /d "%target_dir%"

REM Check if Git executable matches the expected path, run fetch.bat or abort.vbs
if /I "%git_path%"=="C:\Program Files\Git\cmd\git.exe" (
    echo Running fetch.bat...
    start /min fetch.bat
) else (
    echo Running abort.vbs...
    start /WAIT abort.vbs
)

REM Return to the original directory
cd /d "%original_dir%"
