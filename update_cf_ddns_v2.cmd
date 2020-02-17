@echo off
cd C:\Users\Aaron\Desktop\CloudFlare_DDNS

rem curl http://ipv4.icanhazip.com/ > dymanic_ip.txt
curl http://v4.ipv6-test.com/api/myip.php > dymanic_ip.txt

for /f "delims== tokens=1,2" %%G in (cf_param.conf) do set %%G=%%H

set /p MY_DYMANIC_IP=<dymanic_ip.txt

curl -X PUT "https://api.cloudflare.com/client/v4/zones/%CF_ZONE_ID%/dns_records/%CF_DNS_RECORD_ID%" -H "X-Auth-Email:chaotic117@gmail.com" -H "X-Auth-Key:%CF_GLOBAL_KEY%" -H "Content-Type:application/json" --data "{\"type\":\"%CF_DNS_TYPE%\",\"name\":\"%CF_DNS_NAME%\",\"content\":\"%MY_DYMANIC_IP%\",\"ttl\":120,\"proxied\":false}" > log.json

more log.json | jq-win64.exe

For /F Tokens^=2Delims^=^" %%F In (
        'jq-win64.exe "[.success]" ".\log.json" 2^>NUL')Do (
        Set "result=%%F"
        SetLocal EnableDelayedExpansion
        Echo( !result!
        EndLocal
    )

rem set val0 = jq-win64.exe "[.success][0]" "log.json"
rem echo "success:%val0%"

pause
