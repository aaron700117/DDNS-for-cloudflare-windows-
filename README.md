# DDNS-for-cloudflare-windows-
 auto update dymanic ip for cloudflare dns

Step1:
run init.cmd
input email of cf's account, cf zone id, cf global key

Step2:
After initialization, you can run update_cf_ddns.cmd directly.
As long as DNS RECORD ID has not changed

References:
https://api.cloudflare.com/#getting-started-requests
https://stedolan.github.io/jq/manual/
