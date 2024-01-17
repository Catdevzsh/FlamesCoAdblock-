#!/bin/bash

# Flames Co. Adblock - 2.0 [C] GPT-X by FlamesLabs
# Blocks general, 18+ ads, and regional ads from US, China, Russia, and worldwide.

# Detect the operating system
OS=$(uname)
if [ "$OS" == "Darwin" ] || [ "$OS" == "Linux" ]; then
    HOSTS_FILE="/etc/hosts"
elif [ "$OS" == "MINGW64_NT-10.0" ]; then
    HOSTS_FILE="/c/Windows/System32/drivers/etc/hosts"
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# URLs of various blocklists
BLOCKLIST_URLS=(
    "https://raw.githubusercontent.com/Cats-Team/AdRules/master/AdRules" # Chinese region ad blocklist
    "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt" # NoCoin ad blocklist
    # Add more URLs as needed
)

echo "Starting Flames Co. Adblock - 2.0..."

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
