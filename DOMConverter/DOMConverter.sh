#!/bin/bash
# Author: PentGuard
# Domain to IPv4 address converter

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

# Bye Ctrl+C
function ctrl_c(){
    echo -e "\n\n ${red}[!] Exit...${end}\n"
    tput cnorm && exit 1
}
trap ctrl_c INT

# Banner
print_banner(){
    echo;
    echo -e " ${yellow} ______   _____  _______ _______ _____ __   _      ______   _____  __   _ _    _ _______  ______ _______ _______  ______ ${end}"    
    echo -e " ${yellow} |     \ |     | |  |  | |_____|   |   | \  |      |       |     | | \  |  \  /  |______ |_____/    |    |______ |_____/ ${end}"     
    echo -e " ${yellow} |_____/ |_____| |  |  | |     | __|__ |  \_|      |_____  |_____| |  \_|   \/   |______ |    \_    |    |______ |    \_ ${end}\n"
    echo -e " ${turquoise} by .PentGuard${end}\n"
}

# Main
main(){
	if [ $# -eq 0 ] || [ ! -f "$1" ]; then
	    echo -e " ${red}[!]${end} ${gray}Use:${end}${red} $0 <file.txt>${end}"
		exit 1
	else
	    while IPc= read -r subdomain;
        do
            ip=$(dig +short +retry=3 "$subdomain" | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | paste -sd " | ")
            echo -e " ${green}[✔]${end} ${blue}DOM:${end} $subdomain ${yellow}->${end} ${blue}IP:${end} $ip" >> IP_address.txt
    
        done < "$1"
	fi
}

# Run
print_banner
main "$1"
