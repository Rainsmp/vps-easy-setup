#!/usr/bin/env bash

# ==============================
# VPS Easy Setup - Colors
# ==============================

RESET='\033[0m'

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

BOLD='\033[1m'

# Messages
success() {
    echo -e "${GREEN}✓${RESET} $1"
}

error() {
    echo -e "${RED}✗${RESET} $1"
}

warning() {
    echo -e "${YELLOW}!${RESET} $1"
}

info() {
    echo -e "${CYAN}→${RESET} $1"
}

# UI
title() {
    echo -e "${PURPLE}${BOLD}$1${RESET}"
}

line() {
    echo -e "${BLUE}────────────────────────────────────────${RESET}"
}

pause() {
    echo
    read -rp "Press Enter to continue..."
}
