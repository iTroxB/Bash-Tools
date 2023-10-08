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

print_banner(){

    echo;
    echo -e "  ${yellow} _  _  _ _     _ _____  _____  _     _  ______ __   __  ______ _______  ______ _______ ${end}"
    echo -e "  ${yellow} |  |  | |_____|   |   |       |_____| |_____    \_/   |_____     |    |______ |  |  | ${end}"
    echo -e "  ${yellow} |__|__| |     | __|__ |_____  |     | ______|    |    ______|    |    |______ |  |  | ${end}"
    echo -e "									${turquoise} by iTrox${end}\n"
}

print_banner

if [ "$#" -ne 1 ]; then
    echo -e "\n ${red}[!] Use: $0 <ip-address>${end}\n"
    exit 1
fi

ip_address="$1"

get_ttl() {
    ip_address=$1
    out=$(ping -c 1 "$ip_address" | awk -F' ' '/ttl/{print $6}')
    ttl_value=$(echo "$out" | grep -oP '\d+')
    echo "$ttl_value"
}

ttl=$(get_ttl "$ip_address")

get_os() {
    ttl=$1
    if [ "$ttl" -ge 0 ] && [ "$ttl" -le 64 ]; then
        echo -e "${yellow}Linux${end}"
    elif [ "$ttl" -ge 65 ] && [ "$ttl" -le 128 ]; then
        echo -e "${blue}Windows${end}"
    else
        echo -e "${red}Not found${end}"
    fi
}

os_name=$(get_os "$ttl")

echo -e " ${gray}$ip_address${end} ${turquoise}(ttl -> $ttl)${end}${gray}:${end} $os_name"
