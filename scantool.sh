#!/bin/bash
# Specify the interface to scan
INTERFACE="eth4"
# Get the IP address and subnet mask for this interface
IP_AND_MASK=$(ip -o -f inet addr show $INTERFACE | awk '/scope global/ {print $4}')
# If IP_AND_MASK is empty, skip this interface
if [ -z "$IP_AND_MASK" ]; then
  echo "No IP address found for $INTERFACE"
  exit 1
fi
# Run a network scan and save the output to a file
nmap -sn -PR $IP_AND_MASK > "${INTERFACE}_scan.txt"
