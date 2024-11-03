@echo off
set "dir=%cd%"
cd %localappdata%\Programs\RemExec
start /min min.bat
cd %dir%
exit