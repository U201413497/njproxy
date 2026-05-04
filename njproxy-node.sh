#!/bin/bash

_INSTALL(){
mkdir /root/njproxy-node && cd /root/njproxy-node
wget https://github.com/U201413497/njproxy/releases/download/njproxy-node/node && chmod +x node
touch /etc/systemd/system/node.service
echo "
[Unit]
Description=Frontend Service
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
ExecStart=/root/njproxy-node/node
Restart=always
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/node.service
systemctl enable node
systemctl restart node
}

_INSTALL
