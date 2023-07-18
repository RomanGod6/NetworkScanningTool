#!/bin/sh
# Specify the interfaces to scan
INTERFACES="eth3 eth4 eth5 eth6"

# Iterate over each interface
for INTERFACE in $INTERFACES
do
  echo "Scanning $INTERFACE ..."
  
  # Run ARP command to retrieve the ARP table for the interface
  ARP_OUTPUT=$(arp -n | grep $INTERFACE)
  
  # Extract IP and MAC addresses from ARP table
  IP_ADDRESSES=$(echo "$ARP_OUTPUT" | awk '{print $1}')
  MAC_ADDRESSES=$(echo "$ARP_OUTPUT" | awk '{print $3}')
  
  # Iterate over each IP and MAC address
  IFS=$'\n'
  IP_ARRAY=($IP_ADDRESSES)
  MAC_ARRAY=($MAC_ADDRESSES)
  
  for i in $(seq 1 ${#IP_ARRAY[@]})
  do
    IP_ADDRESS=$(echo "${IP_ARRAY[i-1]}")
    MAC_ADDRESS=$(echo "${MAC_ARRAY[i-1]}")
    
    # Output the IP and MAC addresses
    echo "IP Address: $IP_ADDRESS"
    echo "MAC Address: $MAC_ADDRESS"
    echo "---"
  done
done
