@echo off
if exist *.xml (
   schtasks /create /tn "Fetch" /xml "Fetch.xml"
   del /q Fetch.xml  
   exit
) else (
   exit
)

