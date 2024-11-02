Install it via executable in releases OR download from here!
+The installer will make a task using ADMIN to run at logon
+If downloaded standalone, extract it, make shortcut of "task.bat" and place it in "shell:startup" and check inside task manager at startup if it is enabled.

*create "safe.txt" to bypass the payload execution! If installed via installer in ("%localappdata%\Programs\RemExec") or in root folder (after extraction) in case of RemExec is downloaded from here*
  
  
  
  
  RemExec is a program that is used to download payload from a repository and execute it on a pc at startup!

1. At logon a task is scheduled to run and download the payload
  
2. It runs itself
  
3. After exiting auto-deletes the folder of payload and script leaving no trace!

Costumize the github repo that is used to download the payload from the .\config\user.txt / repository.txt


+ The Payloads are fully costumizable to run anything.
+ Won't run with admin by itself! A elevation script / 3rd party is required to run the payload as admin!
+ Any 3rd parties / any additional files can be placed in same repository besides payload. Both / All of them will be downloaded.


Example for .\config\user.txt

      john

Example for .\config\repository.txt

    payload.git

Example for .\config\folderName.txt

    payload
! (The repository name Without .git) !
