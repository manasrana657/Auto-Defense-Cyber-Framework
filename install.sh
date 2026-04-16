#!/bin/bash

echo "[+] Installing tools..."

sudo apt update
sudo apt install -y snort wireshark clamav fail2ban iptables nmap net-tools openvas

sudo systemctl enable fail2ban
sudo systemctl start fail2ban

sudo freshclam

echo "[+] Done!"
