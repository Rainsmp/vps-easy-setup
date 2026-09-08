#!/usr/bin/env bash

show_progress() {
    local message="$1"

    echo -ne "\r${CYAN}→${RESET} $message"
}

progress_done() {
    echo -e "\r${GREEN}✓${RESET} $1"
}

progress_failed() {
    echo -e "\r${RED}✗${RESET} $1"
}
