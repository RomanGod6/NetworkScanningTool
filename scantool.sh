#!/bin/sh
# Specify the interfaces to scan
INTERFACES="eth3 eth4 eth5 eth6"

# Iterate over each interface
for INTERFACE in $INTERFACES
do
  # Get the IP address and subnet mask for this interface
  IP_AND_MASK=$(ifconfig $INTERFACE | awk '/inet / {print $2}')
  # If IP_AND_MASK is empty, skip this interface
  if [ -z "$IP_AND_MASK" ]; then
    echo "No IP address found for $INTERFACE"
    continue
  fi
  # Run a network scan and save the output to a file
  nmap -sn -PR $IP_AND_MASK > "${INTERFACE}_scan.txt"
done
