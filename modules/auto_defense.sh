#!/bin/bash
source core/logger.sh

log "Running smart detection engine..."

LOG_FILE="/var/log/auth.log"
MAX_ATTEMPTS=10

# Count recent failed attempts
attempts=$(grep "Failed password" $LOG_FILE | tail -n 100 | wc -l)

log "Recent failed attempts: $attempts"

if [ "$attempts" -gt "$MAX_ATTEMPTS" ]; then

    log "Brute-force attack detected!"

    ips=$(grep "Failed password" $LOG_FILE | tail -n 100 | awk '{print $(NF-3)}' | sort | uniq)

    for ip in $ips
    do
        # Skip localhost (both IPv4 + IPv6)
        if [[ "$ip" == "127.0.0.1" || "$ip" == "::1" ]]; then
            log "Skipping localhost IP: $ip"
            continue
        fi

        # Check IPv6
        if [[ "$ip" == *":"* ]]; then
            ip6tables -L INPUT -v -n | grep "$ip" > /dev/null

            if [ $? -ne 0 ]; then
                log "Blocking IPv6 attacker IP: $ip"
                ip6tables -A INPUT -s $ip -j DROP
            else
                log "IPv6 IP already blocked: $ip"
            fi

        else
            # IPv4
            iptables -L INPUT -v -n | grep "$ip" > /dev/null

            if [ $? -ne 0 ]; then
                log "Blocking IPv4 attacker IP: $ip"
                iptables -A INPUT -s $ip -j DROP
            else
                log "IPv4 IP already blocked: $ip"
            fi
        fi
    done

else
    log "No major threat detected"
fi

# Optional port scan detection
scan_attempts=$(netstat -an | grep SYN_RECV | wc -l)

if [ "$scan_attempts" -gt 20 ]; then
    log "Possible port scan detected!"
fi

log "Smart detection completed"
