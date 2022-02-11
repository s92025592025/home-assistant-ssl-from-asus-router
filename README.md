# home-assistant-ssl-from-asus-router
[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/s920255920W)
## About
This add-on helps transfer the SSL sertificate that Asus Routers creates along with it's DDNS feature into Homeassitant.

## Configurable Options
| key | Type | Description | Required/Optional 
| --- | --- | --- | --- 
| routerUser | String | The user name to scp with router | Required
| routerIp | String | The IP Address to the Router | Required
| rsaPrivateKeyPath | String | The path relative to `config` folder that points to the RSA private key need to establish the scp connection | Required
| keyFilePathOnRouter | String | The key file path on the router | Required
| certFilePathOnRouter | String | The cert file path on the router | Required