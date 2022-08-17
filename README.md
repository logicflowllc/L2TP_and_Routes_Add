Добавление учётной записи L2TP/IPSec с привызяванием маршрутов
================

Типичная задача: добавить пользователю L2TP/IPSec аккаунт и прописать маршруты за туннелем.

Для примера берём VPN, за которым нам нужен доступ к сетям
* 192.168.1.0/20
* 192.168.20.0/22
* 192.168.50.0/24


## Упаковываем всё в скрипт .PS1

Запускаем его от имени Администратора. Внутри:

* Разрешаем выполнение скриптов, если это ещё не разрешено: 
```
Set-ExecutionPolicy RemoteSigned
```
* Устанавливаем необходимый пакет для сохранения паролей: 
```
Install-Module -Name VPNCredentialsHelper -Confirm
```
* Добавляем аккаунт: 
```
Add-VpnConnection -Name "VPN_NAME" -ServerAddress "VPN_SERVER_ADDRESS" -TunnelType "L2tp" -L2tpPsk "IPSEC_PASSWORD" -Force -EncryptionLevel "Required" -AuthenticationMethod MSChapv2 -SplitTunneling -RememberCredential -PassThru;
```
заменяя поля **VPN_NAME**, **VPN_SERVER_ADDRESS** и **IPSEC_PASSWORD** на ваши.
* Привязываем маршруты к нашему соединению (в нашем случае их 3): 
```
Add-VpnConnectionRoute -ConnectionName "VPN_NAME" -DestinationPrefix 192.168.1.0/20;
Add-VpnConnectionRoute -ConnectionName "VPN_NAME" -DestinationPrefix 192.168.20.0/22;
Add-VpnConnectionRoute -ConnectionName "VPN_NAME" -DestinationPrefix 192.168.50.0/24;
```
* Сохраняем логин и пароль для L2TP аккаунта:
```
Set-VpnConnectionUsernamePassword -connectionname "VPN_NAME" -username "L2TP_USER_NAME" -password "L2TP_USER_PASSWORD"
```
Поля **L2TP_USER_NAME** и **L2TP_USER_PASSWORD** меняем на свои.

**Важно!** Имя соедиения **VPN_NAME** не должно меняться внутри одного скрипта!