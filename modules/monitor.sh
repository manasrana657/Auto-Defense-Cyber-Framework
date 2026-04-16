#!/bin/bash
source core/logger.sh

log "Monitoring logs..."
sudo tail -f /var/log/auth.log
