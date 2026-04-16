#!/bin/bash
source core/logger.sh

log "Starting Fail2Ban..."
sudo systemctl start fail2ban
