@echo off
set /p user=<.\config\user.txt
set /p repo=<.\config\repository.txt
set /p folder=<.\config\folderName.txt


if exist %folder%\ (
  rmdir /s /q %localappdata%\Programs\RemExec\Payloads
  call git clone https://github.com/%user%/%repo%
  start /min execute.bat
  exit
) else (
  call git clone https://github.com/%user%/%repo%
  start /min execute.bat
  exit
)