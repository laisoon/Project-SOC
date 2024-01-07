#!/bin/bash
#Project SOC Checker (CFC 090423) Gan Lai Soon S19
#trainer : James

# Function to perform Attack 1 (Port Scan using Nmap)
attack1() {
    attack_name="Port Scan using Nmap"
    echo "Performing Attack 1: $attack_name"
    read -p "Enter the target IP address for the port scan: " target_ip
    nmap -p 1-100 $target_ip  # for demonstration and learning purposes - we will just run a Port scan from 1 to 100
    echo "Attack 1: $attack_name executed at $(date)" >> /var/log/attacks.log
    echo "Attack 1: $attack_name completed."
}

# Function to perform Attack 2 (FTP Brute-force using Hydra)
attack2() {
    attack_name="FTP Brute-force using Hydra"
    echo "Performing Attack 2: $attack_name"
    read -p "Enter the target FTP server IP address: " target_ip
    read -p "Enter the FTP username: " username
    read -s -p "Enter the FTP password : " password
    echo  # Add a newline after reading the password
    hydra -l $username -p $password -vv ftp://$target_ip
    echo "Attack 2: $attack_name executed at $(date)" >> /var/log/attacks.log
    echo "Attack 2: $attack_name completed."
}

# Function to perform Attack 3 (Port Scanning using Masscan)
attack3() {
    attack_name="Port Scanning using Masscan"
    echo "Performing Attack 3: $attack_name"
    read -p "Enter the target IP  for the scan : " target
    sudo masscan -pU:1-65535 $target -oL masscan_results.txt
    echo "Attack 3: $attack_name executed at $(date)" >> /var/log/attacks.log
    echo "Attack 3: $attack_name completed. Masscan results saved in masscan_results.txt."
}

# Function to display a list of available attacks
list_attacks() {
    echo "Available Attacks:"
    echo "1. Attack 1: Port Scan using Nmap"
    echo "2. Attack 2: FTP Brute-force using Hydra"
    echo "3. Attack 3: Port Scanning using Masscan"
}
#Current local machine IP address
ip_add=$(hostname -I)

echo "Current local machine IP address: $ip_add"

# Function to display IP addresses on the network using nmap
display_ips() {
    echo "IP Addresses on the network:"
    sudo arp-scan --localnet 2>/dev/null | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'
}


# Main menu
echo "SOC Manager - Automatic Attack System"
list_attacks
display_ips

read -p "Choose an attack (1-3) or 'q' to quit: " choice

case $choice in
    1)
        attack1
        ;;
    2)
        attack2
        ;;
    3)
        attack3
        ;;
    q)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac

echo "Target IP: $target_ip"

# Log the attack, timestamp, and target IP
echo "Attack chosen: Attack $choice - $attack_name" >> /var/log/attacks.log
echo "Time of execution: $(date)" >> /var/log/attacks.log
echo "Target IP: $target_ip" >> /var/log/attacks.log

echo "Attack completed successfully."
