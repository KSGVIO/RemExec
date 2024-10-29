@echo off
timeout /t 1 /nobreak > nul
rmdir /s /q %localappdata%\Programs\RemExec\Payloads
exit /b