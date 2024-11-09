@echo off
for /f "delims=" %%a in ('type %localappdata%\Programs\RemExec\config\path.txt') do set path=%%a
timeout /t 1 /nobreak > nul
rmdir /s /q %path%\Payloads
exit