#!/bin/bash

echo "===== SYSTEM STATUS ====="
sudo iptables -L | head -10
sudo systemctl is-active fail2ban
tail -5 logs/framework.log
