@echo off
for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\path.txt') do set path=%%a
set "dir=%cd%"
cd %path%
start /min min.bat
cd %dir%
exit