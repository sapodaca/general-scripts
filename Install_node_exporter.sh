#!/bin/bash
#Download File
/usr/bin/curl -LO https://github.com/prometheus/node_exporter/releases/download/v0.16.0/node_exporter-0.16.0.linux-amd64.tar.gz /tmp

/usr/bin/tar -xvzf /tmp/node_exporter-0.16.0.linux-amd64.tar.gz

/usr/bin/mv node_exporter-0.16.0.linux-amd64.tar.gz /etc/node_exporter/
/usr/bin/cd /etc/node_exporter

/usr/bin/touch /etc/systemd/system/node_exporter.service

echo
"[Unit]
Description=Node Exporter

[Service]
User=prometheus
ExecStart=/home/prometheus/Prometheus/node_exporter/node_exporter

[Install]
WantedBy=default.target" >> /etc/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl enable node_exporter.service
systemctl start node_exporter.service

netstat -anlp | grep LISTEN | grep 9100
curl - http://your_server_ip:9100/metrics
