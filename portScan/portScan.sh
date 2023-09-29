#!/bin/bash
# Author: aKa iTrox

########################
##### COLOURS EDIT #####
########################

green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"


function ctrl_c(){
    echo -e "\n\n${red}[!] Exit...${end}\n"
    tput cnorm; exit 1
}

# Ctrl+C
trap ctrl_c INT


print_banner() {

    echo;
    echo -e "  ${yellow}  _____   _____   _____  _______  ______  _____   _____  __   _ ${end}"
    echo -e "  ${yellow} |_____] |     | |_____/    |    |_____  |       |_____| | \  | ${end}"
    echo -e "  ${yellow} |       |_____| |    \_    |    ______| |_____  |     | |  \_| ${end}\n"
    echo -e "						${turquoise}by iTrox${end}\n"
}

print_banner

if [ $1 ]; then
	ip_address=$1

	echo -e " ${turquoise}[+]${end} ${gray}Starting the scan all ports of IP address $1 ...${end}\n"
	for port in $(seq 1 65535); do
		timeout 1 bash -c "echo ' ' > /dev/tcp/$ip_address/$port" 2>/dev/null && echo -e " ${turquoise}->${end} ${gray}Port${end} ${blue}$port${end} ${green}OPEN${end}"
	done; wait
else
	echo -e " ${red}[!] Error: Invalid format. Try again.${end}"
	echo -e "\n ${yellow}[*] Use: portScan <ip_address>${end}\n"
	exit 1
fi
