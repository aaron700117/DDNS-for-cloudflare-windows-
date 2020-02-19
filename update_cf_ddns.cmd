@echo off
cd %CD%

echo ----------Get Current IP----------
rem curl http://ipv4.icanhazip.com/ > dymanic_ip.txt
curl http://v4.ipv6-test.com/api/myip.php > dymanic_ip.txt

for /f "delims== tokens=1,2" %%G in (cf_param.ini) do set %%G=%%H

set /p MY_DYMANIC_IP=<dymanic_ip.txt

echo ------------Update DNS------------
curl -X PUT "https://api.cloudflare.com/client/v4/zones/%CF_ZONE_ID%/dns_records/%CF_DNS_RECORD_ID%" -H "X-Auth-Email:%CF_EMAIL%" -H "X-Auth-Key:%CF_GLOBAL_KEY%" -H "Content-Type:application/json" --data "{\"type\":\"A\",\"name\":\"%CF_DNS_NAME%\",\"content\":\"%MY_DYMANIC_IP%\",\"ttl\":120,\"proxied\":false}" > log.json

echo ----------Server Response----------

more log.json | jq-win64.exe

more cf.json | jq-win64.exe "[.success][0]" > tmp.txt
set /p status=<tmp.txt
SetLocal EnableDelayedExpansion
echo -----------------------------------
echo Update Status:!status!
EndLocal

IF exist "tmp.txt"  ( del /Q tmp.txt ) 

pause
