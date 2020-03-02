# DDNS-for-cloudflare-windows-
### Auto update dymanic ip for cloudflare dns ###

-----------------------------------

### Step1: ###

Run
    init.cmd

(執行 init.cmd)


Input email of cf's account, cf Zone id, cf API key

(輸入 cf註冊的email, cf的Zone id, cf的API KEY)

-----------------------------------
### Step2: ###


After initialization, you can run update_cf_ddns.cmd directly.


(初始化以後，再次執行只需要直接運行update_cf_ddns.cmd)

As long as DNS RECORD ID has not changed

(只要DNS RECORD ID沒有改變)

-----------------------------------
### Other ###

This batch only update TYPE A DNS Record.

(這批次檔只更新DNS的A紀錄)

IP (123.123.123.123) <- A Record (domain.com) <- CNAME (www.domain.com) <- 外部訪問(External access)

How to find Cloudflare Zone id to configure it with WP Rocket?

(如何找到Zone ID: OverView頁面的右下)

https://community.cloudflare.com/t/how-to-find-cloudflare-zone-id-to-configure-it-with-wp-rocket/83131

How to Generate API token

(如何生成API令牌)

To generate an API token:

1. Log in to the Cloudflare dashboard.

2. Under the My Profile dropdown, click My Profile.

3. Click the API tokens tab.

4. Click the Create Token button. You will see the Create Token screen.

https://support.cloudflare.com/hc/en-us/articles/200167836-Where-do-I-find-my-Cloudflare-API-key-

-----------------------------------
### References: ###

(參考資料:)

https://api.cloudflare.com/#getting-started-requests

https://stedolan.github.io/jq/manual/

https://ss64.com/nt/
