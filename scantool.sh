#!/bin/sh
# Specify the interfaces to scan
INTERFACES="eth3 eth4 eth5 eth6"

# Iterate over each interface
for INTERFACE in $INTERFACES
do
  echo "Scanning $INTERFACE ..."

  # Run ARP command to retrieve the ARP table for the interface
  ARP_OUTPUT=$(arp)
  
  # Print the ARP output for debugging
  echo "ARP output: $ARP_OUTPUT"
  
  # Filter the ARP output for the current interface
  INTERFACE_ARP_OUTPUT=$(echo "$ARP_OUTPUT" | grep $INTERFACE)
  
  # Print the filtered ARP output for debugging
  echo "Filtered ARP output for $INTERFACE: $INTERFACE_ARP_OUTPUT"

  # Use a while-read loop to iterate over the lines of the ARP output
  echo "$INTERFACE_ARP_OUTPUT" | while read -r line
  do
    # Extract the IP and MAC addresses from the line
    IP_ADDRESS=$(echo "$line" | awk '{print $1}')
    MAC_ADDRESS=$(echo "$line" | awk '{print $3}')
    
    # Output the IP and MAC addresses
    echo "IP Address: $IP_ADDRESS"
    echo "MAC Address: $MAC_ADDRESS"
    echo "---"
  done
done
