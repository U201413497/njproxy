#!/bin/bash

_INSTALL(){
wget https://github.com/U201413497/njproxy/releases/download/juicity-server/juicity-server
mv juicity-server /usr/local/bin/ && chmod +x /usr/local/bin/juicity-server
touch /etc/systemd/system/juicity-server.service
echo "
[Unit]
Description=juicity-server Service
Documentation=https://github.com/juicity/juicity
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/juicity-server run -c /usr/local/etc/juicity/server.json --disable-timestamp
Restart=on-failure
LimitNPROC=512
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/juicity-server.service
mkdir /usr/local/etc/juicity && touch /usr/local/etc/juicity/server.json
cat >/usr/local/etc/juicity/server.json <<-EOF
{
    "listen": ":23182",
    "users": {
        "00000000-0000-0000-0000-000000000000": "my_password"
    },
    "certificate": "/path/to/fullchain.cer",
    "private_key": "/path/to/private.key",
    "congestion_control": "bbr",
    "log_level": "info"
}
EOF
systemctl enable juicity-server && systemctl restart juicity-server
}
_INSTALL
