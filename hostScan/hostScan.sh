#!/bin/bash
# Author: iTrox

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


print_banner(){

    echo;
    echo -e "  ${yellow} _     _  _____   ______ _______  ______  _____   _____  __   _ ${end}"
    echo -e "  ${yellow} |_____| |     | |_____     |    |_____  |       |_____| | \  | ${end}"
    echo -e "  ${yellow} |     | |_____| ______|    |    ______| |_____  |     | |  \_| ${end}"
    echo -e "                                            ${turquoise} by iTrox${end}\n"
}

print_banner


if [ "$1" ]; then
    echo -e " ${turquoise}[+]${end} ${gray}Starting host scan to address $1 ...${end}\n"

    base_ip=$(echo "$1" | cut -d '.' -f 1-3)

    for i in $(seq 1 254); do
        current_ip="$base_ip.$i"
        timeout 1 bash -c "ping -c 1 $current_ip &>/dev/null" && echo -e " ${turquoise}->${end} ${gray}Host${end} ${blue}$current_ip${end} ${gray}|${end} ${green}ACTIVE${end}"
    done
else
    echo -e " ${red}[!] Error: Invalid format. Try again.${end}"
    echo -e "\n ${yellow}[*] Use: hostScan <ip_address>${end}\n"
    exit 1
fi

wait
