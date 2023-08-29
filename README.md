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
testapp_IP = 158.160.107.14
testapp_port = 9292

# CLI команда для деплоя приложения
yc compute instance create --name reddit-app --hostname reddit-app --memory=4 --core-fraction 50 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=15GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --preemptible --metadata serial-port-enable=1 --metadata-from-file user-data=startup-script.yaml

# Проверка работы приложения
http://158.160.107.14:9292/

# startup-script
#cloud-config
ssh_pwauth: false
users:
  - name: yc-user
    groups: sudo
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh-authorized-keys:
      - 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNJwQoQdYdt86rzaRqU/QXOuW672c+ITshYx4d6TXRG2xR8b9tKjx7egXFLXsT+evGeBIuS2Q/k+5RGWNSjPqSC6tbshkjsDnuD98AEVthb47MIDD3WwkkOZPAoO59OfS1dsOG3ehue/+BwSJr/vcGwqVIHcrkzOUHjlklobdbieGR1dG6A9aedYEfLZbuypfUaVrkS6eO09GAVsS/St1kGPv4XGuq19MK0AZQs6QoIAu5YhcC1OLv4vj1tlULo+V5BVx9SJ7A6VtAsg6jbFpORuDSXqy0Hx4i5VEo/ukeR8bhJDiSoAl/WTVA5Ln730GLzf8zDn/RauV6sQQdnCzEg+jAfj9nRjo+CpV0GA7wzy//01bDFRbUVmaFSqm0dEe9EvzF7u/jadmxOHbWK8zcMZaW9nLqMbfRxJw9xSryrUW8HJ/xDkCUFx4FAyPIvUfd0Bema8AlUhI3QQ3FfmfgtbUyJahfy5qPDnQ4wipQjzo2v/rGicGPjfsacyKWR7c= avgroup\k.pospelov@AV-NB-6027352'
package_update: true
package_upgrade: true
packages:
  - git
runcmd:
  - sudo git clone https://github.com/Otus-DevOps-2023-07/poskon_infra.git /home/yc-user/poskon_infra
  - cd /home/yc-user/poskon_infra
  - sudo git checkout cloud-testapp
  - sudo /home/yc-user/poskon_infra/install_ruby.sh && sudo /home/yc-user/poskon_infra/install_mongodb.sh && sudo /home/yc-user/poskon_infra/deploy.sh
  - sudo rm -r /home/yc-user/poskon_infra
