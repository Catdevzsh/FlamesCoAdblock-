#!/bin/bash

# Flames Co. Adblock - 1.0 [C] GPT-X by FlamesLabs
# Blocks general, 18+ ads, and regional ads from US, China, Russia, and worldwide.

# Path to the hosts file
HOSTS_FILE="/etc/hosts"

# URLs of various blocklists
BLOCKLIST_URLS=(
    "https://raw.githubusercontent.com/Cats-Team/AdRules/master/AdRules" # Chinese region ad blocklist
    "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt" # NoCoin ad blocklist
    # Add more URLs as needed
)

echo "Starting Flames Co. Adblock - 1.0..."

# Backup the original hosts file
sudo cp $HOSTS_FILE "${HOSTS_FILE}.bak"

# Function to download and append blocklists
append_blocklist() {
    local url=$1
    {
        echo "# Begin blocklist from $url"
        curl -s $url | grep -v "^#" | grep -v "^$" 
        echo "# End blocklist from $url"
    } | sudo tee -a $HOSTS_FILE
}

# Append each blocklist to the hosts file
for url in "${BLOCKLIST_URLS[@]}"
do
    append_blocklist $url
done

echo "Blocklists integrated and hosts file updated."
