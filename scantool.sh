#!/bin/sh
# Specify the interfaces to scan
INTERFACES="eth3 eth4 eth5 eth6"

# Iterate over each interface
for INTERFACE in $INTERFACES
do
  echo "Scanning $INTERFACE ..."
  
  # Retrieve the ARP table for the interface from /proc/net/arp
  ARP_OUTPUT=$(cat /proc/net/arp | grep $INTERFACE)
  
  # Use a while-read loop to iterate over the lines of the ARP output
  echo "$ARP_OUTPUT" | while read -r line
  do
    # Extract the IP and MAC addresses from the line
    IP_ADDRESS=$(echo "$line" | awk '{print $1}')
    MAC_ADDRESS=$(echo "$line" | awk '{print $4}')
    
    # Output the IP and MAC addresses
    echo "IP Address: $IP_ADDRESS"
    echo "MAC Address: $MAC_ADDRESS"
    echo "---"
  done
done
