start "" /b "C:\xampp\apache\bin\httpd.exe"
start "" /b "microsoft-edge:http://localhost/reaction_time_task"
:file_check
IF EXIST "C:\Users\%username%\Downloads\*_reaction_time_task_*.csv" GOTO file_exists
TIMEOUT /T 1 >nul
GOTO file_check
:file_exists
ECHO "Behavior files downloaded, moving to Dropbox..."
move /-Y "C:\Users\%username%\Downloads\*_reaction_time_task_*.csv" "C:\Users\%username%\Starr Lab Dropbox\Projects\Go_NoGo\behavioral_data"
start /b "" "C:\xampp\apache_stop.bat"
:exit