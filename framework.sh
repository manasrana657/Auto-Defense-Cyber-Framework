#!/bin/bash

# Force root
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo"
    exit
fi

while true
do
    clear
    bash core/banner.sh

    echo "1. Setup Firewall"
    echo "2. Run IDS"
    echo "3. Vulnerability Scan"
    echo "4. Antivirus Scan"
    echo "5. Enable DDoS Protection"
    echo "6. Brute Force Protection"
    echo "7. Monitoring"
    echo "8. Smart Auto Defense"
    echo "9. System Status"
    echo "10. View Logs"
    echo "11. Exit"

    read -p "Select option: " choice

    case $choice in
        1) sudo bash modules/firewall.sh ;;
        2) sudo bash modules/ids.sh ;;
        3) sudo bash modules/scanner.sh ;;
        4) sudo bash modules/antivirus.sh ;;
        5) sudo bash modules/ddos.sh ;;
        6) sudo bash modules/brute_force.sh ;;
        7) sudo bash modules/monitor.sh ;;
        8) sudo bash modules/auto_defense.sh ;;
        9) sudo bash modules/status.sh ;;
        10) less logs/framework.log ;;
        11) exit ;;
        *) echo "Invalid option"; sleep 1 ;;
    esac

    read -p "Press Enter to continue..."
done
