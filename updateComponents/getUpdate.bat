@echo off
set "dir=%cd%"
cd %localappdata%\Programs\RemExec\updateComponents
git clone https://github.com/KSGVIO/RemExec.git
cd %dir%