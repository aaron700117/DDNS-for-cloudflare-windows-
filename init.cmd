@echo off

rem #### change to your work path ###
cd %CD%

set CONFIG=cf_param.ini
set /P CF_EMAIL="input E-mail of CloudFlare's account:"
echo %CF_EMAIL%

set /P CF_ZONE_ID="input Zone ID:"
echo %CF_ZONE_ID%

set /P CF_GLOBAL_KEY="input Global Key:"
echo %CF_GLOBAL_KEY%

echo ------Get Zone Information------
curl -X GET "https://api.cloudflare.com/client/v4/zones/%CF_ZONE_ID%/dns_records" -H "x-auth-email:%CF_EMAIL%" -H "x-auth-key:%CF_GLOBAL_KEY%" -H "content-type: application/json" > cf.json
echo --------------------------------
setlocal enabledelayedexpansion

more cf.json | jq-win64.exe "[.result_info.count][0]" > .\tmp.txt
set /p count=<tmp.txt
echo record_count:!count!
echo --------------------------------
IF exist "%CONFIG%"  ( del /Q %CONFIG% ) 

echo CF_ZONE_ID=%CF_ZONE_ID%>>%CONFIG%
echo CF_GLOBAL_KEY=%CF_GLOBAL_KEY%>>%CONFIG%
echo CF_EMAIL=%CF_EMAIL%>>%CONFIG%

set typeA="A"
rem echo !typeA!

set /a "count=%count%-1"

For /L %%i IN (0,1,%count%) Do (
	more cf.json | jq-win64.exe "[.result[%%i].type][0]" > tmp.txt
	set /p jtype=<tmp.txt	
	more cf.json | jq-win64.exe "[.result[%%i].id][0]" > tmp.txt
	set /p rid=<tmp.txt
	set rid=!rid:~1!
	set rid=!rid:~0,-1!
	rem echo !tid!
	rem echo !jtype!
	more cf.json | jq-win64.exe "[.result[%%i].name][0]" > tmp.txt
	set /p name=<tmp.txt
	set name=!name:~1!
	set name=!name:~0,-1!
	for /f "tokens=* delims= " %%a in ("%name%") do set name=%%a
	for /l %%a in (1,1,100) do if "!name:~-1!"==" " set name=!name:~0,-1!
	echo [%%i] record_id [!rid!] record_type [!jtype!] name [!name!]
	IF [!jtype!] == [!typeA!] (echo CF_DNS_RECORD_ID=!rid!>>cf_param.ini) else ( echo [%%i] NOT TYPE A )
	IF [!jtype!] == [!typeA!] (echo CF_DNS_NAME=!name!>>cf_param.ini) 
)

IF exist "tmp.txt"  ( del /Q tmp.txt ) 

set zero=1
if %count% GEQ !zero! (goto update)
if %count% LSS !zero! (goto error)

EndLocal

:update
echo --------------------------------
echo ### Initialization done. ###
echo ### press any key to perform DNS update ###
pause
call .\update_cf_ddns.cmd
goto end

:error
echo "Not load correct cf dns record id"
pause

:end

