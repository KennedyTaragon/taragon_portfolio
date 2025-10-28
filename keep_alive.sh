#!/bin/bash

# Render Free Tier Keep-Alive Script
# Pings your Render service every 14 minutes to prevent sleep after 15 minutes of inactivity

URL="https://taragon-portfolio.onrender.com/"
INTERVAL=840  # 14 minutes in seconds (14 * 60 = 840)

echo "Starting Render Keep-Alive script for: $URL"
echo "Ping interval: 14 minutes"
echo "Press Ctrl+C to stop"
echo "---"

# Function to ping the server
ping_server() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Use curl to ping the server
    response=$(curl -s -o /dev/null -w "%{http_code}" --max-time 30 "$URL")
    
    if [ "$response" -eq 200 ] || [ "$response" -eq 301 ] || [ "$response" -eq 302 ]; then
        echo "[$timestamp] ✓ Server pinged successfully (HTTP $response)"
    else
        echo "[$timestamp] ✗ Server ping failed (HTTP $response)"
    fi
}

# Initial ping
ping_server

# Continuous ping loop
while true; do
    sleep $INTERVAL
    ping_server
done