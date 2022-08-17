# Разрешаем выполнение скриптов
Set-ExecutionPolicy RemoteSigned

# Устанавливаем пакет, необходимый для сохранения паролей
Install-Module -Name VPNCredentialsHelper -Confirm

# Добавляем соединение L2TP, указываем IPSec пароль
Add-VpnConnection -Name "VPN_NAME" -ServerAddress "VPN_SERVER_ADDRESS" -TunnelType "L2tp" -L2tpPsk "IPSEC_PASSWORD" -Force -EncryptionLevel "Required" -AuthenticationMethod MSChapv2 -SplitTunneling -RememberCredential -PassThru;

# Добавляем маршруты до нужных сетей за L2TP соединением
Add-VpnConnectionRoute -ConnectionName "VPN_NAME" -DestinationPrefix 192.168.1.0/20;
Add-VpnConnectionRoute -ConnectionName "VPN_NAME" -DestinationPrefix 192.168.20.0/22;
Add-VpnConnectionRoute -ConnectionName "VPN_NAME" -DestinationPrefix 192.168.50.0/24;

# Сохраняем логин и пароль L2TP
Set-VpnConnectionUsernamePassword -connectionname "VPN_NAME" -username "L2TP_USER_NAME" -password "L2TP_USER_PASSWORD"