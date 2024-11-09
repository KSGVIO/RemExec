@echo off
for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\path.txt') do set path=%%a
set /p user=<.\config\user.txt
set /p repo=<.\config\repository.txt
set /p folder=<.\config\folderName.txt


if exist %folder%\ (
  rmdir /s /q %path%\Payloads
  call git clone https://github.com/%user%/%repo%
  start /min execute.bat
  exit
) else (
  call git clone https://github.com/%user%/%repo%
  start /min execute.bat
  exit
)