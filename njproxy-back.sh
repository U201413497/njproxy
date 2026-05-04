#!/bin/bash

_INSTALL(){
mkdir /root/njproxy-back && cd /root/njproxy-back
wget https://github.com/U201413497/njproxy/releases/download/njproxy-back/backend && chmod +x backend
touch /etc/systemd/system/backend.service
echo "
[Unit]
Description=Backend Service
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
ExecStart=/root/njproxy-back/backend
Restart=always
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/backend.service
systemctl enable backend
systemctl restart backend
}

_INSTALL
