start "" /b "C:\xampp\apache\bin\httpd.exe"
start "" /b "microsoft-edge:http://localhost/reaction_time_task"
:file_check
IF EXIST "C:\Users\%username%\Downloads\*_reaction_time_task_*.csv" GOTO file_exists
TIMEOUT /T 1 >nul
GOTO file_check
:file_exists
ECHO "Behavior files downloaded, moving to Dropbox..."

set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
set CUR_NN=%time:~3,2%

set SUBFILENAME=%CUR_YYYY%%CUR_MM%%CUR_DD%-%CUR_HH%%CUR_NN%%CUR_SS%

move /-Y "C:\Users\%username%\Downloads\*_go_nogo_calib_task_*.csv" "C:\Users\%username%\Starr Lab Dropbox\Projects\Go_NoGo\behavioral_data_%SUBFILENAME%.csv"

start /b "" "C:\xampp\apache_stop.bat"
:exit