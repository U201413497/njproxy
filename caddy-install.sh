#!/bin/bash

_INSTALL(){
wget https://github.com/U201413497/njproxy/releases/download/caddy/caddy
chmod +x caddy && mv caddy /usr/local/bin/
mkdir /etc/caddy && touch /etc/caddy/Caddyfile
touch /etc/systemd/system/caddy.service
echo "
[Unit]
Description=Caddy HTTP/2 web server
Documentation=https://caddyserver.com/docs
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
ExecStart=/usr/local/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/local/bin/caddy reload --config /etc/caddy/Caddyfile
Restart=always
RestartPreventExitStatus=23
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/caddy.service
systemctl enable caddy
echo -n "Enter your domain:"
read domain
echo -n "Enter your email:"
read email
echo ":443, $domain
        tls $email
        route {
            reverse_proxy https://demo.cloudreve.org {
            header_up Host {upstream_hostport}
            header_up X-Forwarded-Host {host}
                                                     }
             }" > /etc/caddy/Caddyfile
systemctl restart caddy
}

_INSTALL
