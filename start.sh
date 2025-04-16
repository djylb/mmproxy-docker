#!/bin/sh

PORT_MAPPINGS_DEFAULT="15000:5000"
PORT_MAPPINGS="${1:-${PORT_MAPPINGS:-$PORT_MAPPINGS_DEFAULT}}"

# Set up routing rules
echo "Setting up routing rules..."
ip rule add from 127.0.0.1/8 iif lo table 123 2>/dev/null || true
ip route add local 0.0.0.0/0 dev lo table 123 2>/dev/null || true
ip -6 rule add from ::1/128 iif lo table 123 2>/dev/null || true
ip -6 route add local ::/0 dev lo table 123 2>/dev/null || true

# Parse the port mappings and start mmproxy for each mapping
for mapping in $(echo $PORT_MAPPINGS | tr "," " "); do
  listen_port=$(echo $mapping | cut -d: -f1)
  target_port=$(echo $mapping | cut -d: -f2)

  echo "Starting port mapping: $listen_port -> 127.0.0.1:$target_port"

  # Start the mmproxy for IPv4 and IPv6
  /app/mmproxy -l "0.0.0.0:$listen_port" -4 "127.0.0.1:$target_port" -6 "[::1]:$target_port" &
done

# Keep the container running
wait
