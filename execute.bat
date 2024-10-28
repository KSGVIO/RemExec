@echo off
if exist ".\payloads\payload.bat" (
   call .\payloads\payload.bat
) else (
   echo 2
)