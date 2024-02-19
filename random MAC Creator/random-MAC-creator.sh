#!/bin/bash
# Author: iTrox

# Random MAC Address creator for MAC spoofing

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
print_banner() {
    echo;
    echo -e " ${yellow}  ______ _______ __   _ ______   _____  _______      _______ _______ ______       ______   ______ _______ _______ _______  _____   ______ ${end}"    
    echo -e " ${yellow} |_____/ |_____| | \  | |     \ |     | |  |  |      |  |  | |_____| |            |       |_____/ |______ |_____|    |    |     | |_____/ ${end}"     
    echo -e " ${yellow} |    \_ |     | |  \_| |_____/ |_____| |  |  |      |  |  | |     | |_____       |_____  |    \_ |______ |     |    |    |_____| |    \_ ${end}\n"
    echo -e " ${turquoise} by .PentGuard${end}\n"
}

# Main
main(){
    first_Octets=($(macchanger -l | awk '{print $3}' | grep -oE '^[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}:[0-9A-Fa-f]{2}' | sort -u | shuf -n 1))
    random_Last_Octets=$(printf '%02X:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
    mac="$first_Octets:$random_Last_Octets"
    
    echo -e " \n${green}[✔]${end} ${gray}Random MAC address create:${end} ${turquoise}$mac${end}"
}

# Run
print_banner
main
