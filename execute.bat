@echo off

if exist ".\payloads\payload.bat" (
   if exist safe.txt (
      rmdir /s /q .\payloads
      exit
    ) else (
        if exist keep.txt (
        cd payloads
        start /min /wait payload.bat
        exit
        ) else (
            cd payloads
            start /min /wait payload.bat
            cd ..
            rmdir /s /q .\payloads
            exit
          )
      )
) else (
    exit
)