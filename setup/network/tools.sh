#!/usr/bin/env bash

tailscale_setup() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              TAILSCALE                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    if ! command_exists tailscale; then
        info "Installing Tailscale..."

        curl -fsSL https://tailscale.com/install.sh | sh || {
            error "Tailscale installation failed."
            pause
            return 1
        }

        success "Tailscale installed."
    else
        success "Tailscale is already installed."
    fi

    echo

    if systemctl list-unit-files 2>/dev/null | grep -q '^tailscaled.service'; then
        systemctl enable --now tailscaled >/dev/null 2>&1 || true
    fi

    if tailscale status >/dev/null 2>&1; then
        success "Tailscale is connected."
        echo
        tailscale status
    else
        info "Starting Tailscale authentication..."
        echo

        tailscale up || {
            warning "Tailscale authentication was not completed."
            echo
            echo "Run this option again after completing authentication."
            pause
            return 1
        }

        echo
        success "Tailscale setup completed."
        echo
        tailscale status
    fi

    pause
}


zerotier_setup() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│               ZEROTIER                 │"
    echo "╰────────────────────────────────────────╯"
    echo

    if ! command_exists zerotier-cli; then
        info "Installing ZeroTier..."

        curl -s https://install.zerotier.com | bash || {
            error "ZeroTier installation failed."
            pause
            return 1
        }

        success "ZeroTier installed."
    else
        success "ZeroTier is already installed."
    fi

    echo

    if systemctl list-unit-files 2>/dev/null | grep -q '^zerotier-one.service'; then
        systemctl enable --now zerotier-one >/dev/null 2>&1 || true
    fi

    echo "ZeroTier status:"
    echo
    zerotier-cli info 2>/dev/null || warning "ZeroTier service is not available."

    echo
    read -rp "Enter ZeroTier Network ID to join (leave empty to skip): " network_id

    if [[ -n "$network_id" ]]; then
        if [[ "$network_id" =~ ^[0-9a-fA-F]{16}$ ]]; then
            zerotier-cli join "$network_id" || {
                error "Failed to join ZeroTier network."
                pause
                return 1
            }

            success "Join request sent."
            echo
            echo "You may need to authorize this device in the ZeroTier network."
            echo
            zerotier-cli listnetworks
        else
            error "Invalid ZeroTier Network ID."
            echo "A Network ID should contain 16 hexadecimal characters."
        fi
    else
        info "No network was joined."
    fi

    pause
}


cloudflare_dns() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│            CLOUDFLARE DNS              │"
    echo "╰────────────────────────────────────────╯"
    echo

    if ! command_exists curl; then
        error "curl is required."
        pause
        return 1
    fi

    echo "This module manages Cloudflare DNS through the Cloudflare API."
    echo
    echo "You will need:"
    echo "  - Cloudflare API Token"
    echo "  - Cloudflare Zone ID"
    echo

    read -rp "Cloudflare API Token: " cf_token
    echo

    if [[ -z "$cf_token" ]]; then
        warning "No API token supplied."
        pause
        return 1
    fi

    read -rp "Cloudflare Zone ID: " zone_id
    echo

    if [[ ! "$zone_id" =~ ^[A-Za-z0-9_-]{20,}$ ]]; then
        error "The Zone ID does not look valid."
        pause
        return 1
    fi

    echo
    info "Checking Cloudflare API access..."

    response="$(
        curl -fsS \
            -H "Authorization: Bearer $cf_token" \
            -H "Content-Type: application/json" \
            "https://api.cloudflare.com/client/v4/zones/$zone_id" \
            2>/dev/null
    )"

    if [[ $? -ne 0 ]]; then
        error "Unable to contact Cloudflare."
        pause
        return 1
    fi

    if echo "$response" | grep -q '"success":true'; then
        success "Cloudflare API authentication successful."
    else
        error "Cloudflare API authentication failed."
        pause
        return 1
    fi

    echo
    echo "Available actions:"
    echo
    echo "1) List DNS records"
    echo "2) Skip"
    echo

    read -rp "Select an option: " cf_option

    case "$cf_option" in
        1)
            echo
            info "DNS records:"
            echo

            curl -fsS \
                -H "Authorization: Bearer $cf_token" \
                -H "Content-Type: application/json" \
                "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records" \
                2>/dev/null || error "Failed to retrieve DNS records."
            ;;
        2)
            info "No DNS changes made."
            ;;
        *)
            warning "Invalid option."
            ;;
    esac

    echo
    pause
}


port_forward() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              PORT FORWARD              │"
    echo "╰────────────────────────────────────────╯"
    echo

    echo "This VPS can expose services directly through its firewall."
    echo "A router-style NAT port forward cannot normally be created"
    echo "on a VPS unless the VPS is acting as a router."
    echo

    read -rp "Enter TCP port to allow (leave empty to cancel): " port

    if [[ -z "$port" ]]; then
        info "Cancelled."
        pause
        return 0
    fi

    if ! [[ "$port" =~ ^[0-9]+$ ]] || (( port < 1 || port > 65535 )); then
        error "Invalid port."
        pause
        return 1
    fi

    echo
    info "Allowing TCP port $port..."

    if command_exists ufw; then
        ufw allow "$port/tcp" || {
            error "Failed to update UFW."
            pause
            return 1
        }

        success "TCP port $port allowed through UFW."
        echo
        ufw status
    else
        warning "UFW is not installed."
        echo "Install it through the Firewall option first."
    fi

    pause
}


web_terminal() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              WEB TERMINAL              │"
    echo "╰────────────────────────────────────────╯"
    echo

    warning "A web terminal provides browser-based shell access."
    echo "This feature should only be exposed through authenticated HTTPS."
    echo

    echo "No web terminal was installed automatically."
    echo "Use SSH for terminal access until a dedicated authenticated"
    echo "web-terminal configuration is added."

    echo
    pause
}


rdp_installer() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│              RDP INSTALLER             │"
    echo "╰────────────────────────────────────────╯"
    echo

    warning "RDP installation can install a complete desktop environment"
    echo "and significantly increase VPS resource usage."
    echo

    if [[ ! -f /etc/os-release ]]; then
        error "Unable to determine the operating system."
        pause
        return 1
    fi

    . /etc/os-release

    echo "Detected OS: ${PRETTY_NAME:-Unknown}"
    echo

    if [[ "$ID" == "kali" ]]; then
        echo "Kali Linux detected."
        echo
        echo "Recommended approach:"
        echo "  1) Install a supported desktop environment"
        echo "  2) Install xrdp"
        echo "  3) Create a normal desktop user"
        echo
        echo "This installer will not automatically change the desktop"
        echo "environment or expose RDP without confirmation."
    else
        echo "Automatic RDP setup is not configured for this distribution."
    fi

    echo
    pause
}


ssl_panel() {
    clear

    echo
    echo "╭────────────────────────────────────────╮"
    echo "│               SSL PANEL                │"
    echo "╰────────────────────────────────────────╯"
    echo

    echo "SSL/TLS certificates should be configured for a specific"
    echo "domain and service."
    echo

    read -rp "Enter domain (leave empty to cancel): " domain

    if [[ -z "$domain" ]]; then
        info "Cancelled."
        pause
        return 0
    fi

    if [[ ! "$domain" =~ ^[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
        error "Invalid domain name."
        pause
        return 1
    fi

    echo
    echo "Domain: $domain"
    echo
    echo "Certificate management has not been automatically enabled."
    echo "The next version can add Let's Encrypt/Certbot support for"
    echo "a selected web service."

    echo
    pause
}
