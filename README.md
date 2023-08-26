# poskon_infra
poskon Infra repository

# Самостоятельное задание
# Для упрощения SSH-доступа и его настройки используется параметр -J (ProxyJump) в команду SSH.
# Пример использования ProxyJump:
ssh -i ~/.ssh/id_rsa -J appuser@<bastion_IP> appuser@<someinternalhost_IP>

# Дополнительное задание:
# Для создания алиаса прописываем настройки для хоста в конфиге ~/.ssh/config
Host someinternalhost
Hostname 10.128.0.9
ForwardAgent yes
User appuser

# После настройки алиаса заходим на сервер
ssh someinternalhost

# Конфигурация
bastion_IP = 130.193.49.244
someinternalhost_IP = 10.128.0.9


# ДЗ #4
testapp_IP =
testapp_port = 9292
