#!/bin/bash

# Allow incoming requests from 192.168.0.0 to 192.168.0.14 (server's IP range)
TRUSTED_RANGE="192.168.0.0/28"

# Reset UFW
ufw --force reset

# Default policies
ufw default deny incoming
ufw default allow outgoing

# Allow trusted range for all ports
ufw allow from "$TRUSTED_RANGE"

# Enable UFW
ufw --force enable

echo "UFW configured. Trusted range: $TRUSTED_RANGE"
