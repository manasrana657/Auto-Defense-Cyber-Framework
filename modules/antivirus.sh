#!/bin/bash
source core/logger.sh

log "Running antivirus scan..."
clamscan -r /home
