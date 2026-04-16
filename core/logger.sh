#!/bin/bash

log_file="logs/framework.log"

log() {
    echo "[+] $(date) - $1" | tee -a $log_file
}

