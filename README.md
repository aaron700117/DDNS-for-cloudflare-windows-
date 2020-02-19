# DDNS-for-cloudflare-windows-
 auto update dymanic ip for cloudflare dns

Step1:
run init.cmd
input email of cf's account, cf zone id, cf global key

Step2:
After initialization, you can run update_cf_ddns.cmd directly.
As long as DNS RECORD ID has not changed

How to find Cloudflare Zone id to configure it with WP Rocket?
https://community.cloudflare.com/t/how-to-find-cloudflare-zone-id-to-configure-it-with-wp-rocket/83131

How to Generate API token
https://support.cloudflare.com/hc/en-us/articles/200167836-Where-do-I-find-my-Cloudflare-API-key-

References:
https://api.cloudflare.com/#getting-started-requests
https://stedolan.github.io/jq/manual/
