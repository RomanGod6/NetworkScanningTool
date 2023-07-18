#!/bin/sh
# Specify the interfaces to scan
INTERFACES="eth3 eth4 eth5 eth6"

# Iterate over each interface
for INTERFACE in $INTERFACES
do
  # Get the IP address and subnet mask for this interface
  IP_AND_MASK=$(ip -o -f inet addr show $INTERFACE | awk '/scope global/ {print $4}')
  # If IP_AND_MASK is empty, skip this interface
  if [ -z "$IP_AND_MASK" ]; then
    echo "No IP address found for $INTERFACE"
    continue
  fi

  echo "Scanning $INTERFACE ..."
  
  # Run ARP command to retrieve the ARP table
  ARP_OUTPUT=$(arp -i $INTERFACE -n)
  
  # Extract IP and MAC addresses from ARP table
  IP_ADDRESSES=$(echo "$ARP_OUTPUT" | awk '{print $1}')
  MAC_ADDRESSES=$(echo "$ARP_OUTPUT" | awk '{print $3}')
  
  # Iterate over each IP and MAC address
  IFS=$'\n'
  IP_ARRAY=($IP_ADDRESSES)
  MAC_ARRAY=($MAC_ADDRESSES)
  
  for ((i=0; i<${#IP_ARRAY[@]}; i++))
  do
    IP_ADDRESS=${IP_ARRAY[i]}
    MAC_ADDRESS=${MAC_ARRAY[i]}
    
    # Run MAC address lookup using MAC address vendor lookup service (macvendors.com)
    VENDOR_INFO=$(curl -s "https://api.macvendors.com/${MAC_ADDRESS}")
    if [ $? -eq 0 ]; then
      DEVICE_VENDOR=$(echo "$VENDOR_INFO" | awk '{$1=""; print $0}')
    else
      DEVICE_VENDOR="Unknown"
    fi
    
    # Output the IP, MAC, and vendor information
    echo "IP Address: $IP_ADDRESS"
    echo "MAC Address: $MAC_ADDRESS"
    echo "Vendor: $DEVICE_VENDOR"
    echo "---"
  done
done
