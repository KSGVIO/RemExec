@echo off
set /p user=<.\config\user.txt
set /p repo=<.\config\repository.txt
call git clone https://github.com/%user%/%repo%
start /min execute.bat
exit
