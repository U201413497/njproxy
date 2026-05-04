#!/bin/bash

_INSTALL(){
mkdir /root/njproxy-front && cd /root/njproxy-front
wget https://github.com/U201413497/njproxy/releases/download/njproxy-front/frontend && chmod +x frontend
touch /etc/systemd/system/frontend.service
echo "
[Unit]
Description=Frontend Service
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
ExecStart=/root/njproxy-front/frontend
Restart=always
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/frontend.service
systemctl enable frontend
systemctl restart frontend
}

_INSTALL
