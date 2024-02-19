#!/bin/bash
# Author: iTrox

# Fuzzer web

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
    echo -e " ${yellow}  _____  _______ __   _ _______ ______  _     _ _______ _______ _______  ______ ${end}"
    echo -e " ${yellow} |_____] |______ | \  |    |    |_____] |     | |______    |    |______ |_____/ ${end}"
    echo -e " ${yellow} |       |______ |  \_|    |    |_____] |_____| ______|    |    |______ |    \_ ${end}\n"
    echo -e " ${turquoise} by .PentGuard${end}\n\n"
    echo -e " ${yellow}->${end} ${gray}HTTP Code:${end} ${blue}200, 301, 302 and 403${end}\n"
}

# Help menu
usage() {
  echo -e " ${red}[!]${end}	 ${gray}Usage:${end} $0 ${blue}--url${end} <target_url> ${blue}--wordlist${end} <wordlist_file> [${blue}--threads${end} <number>]"
  echo -e " ${blue}--url${end}		${gray}Target URL (including authentication if required)${end}"
  echo -e " ${blue}--wordlist${end}	${gray}Wordlist${end}"
  echo -e " ${blue}--threads${end}	${gray}Threads number (default=5)${end}"
  exit 1
}

# Principal while
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --url)
      url="$2"
      shift 2
      ;;
    --wordlist)
      wordlist="$2"
      shift 2
      ;;
    --threads)
      threads="$2"
      shift 2
      ;;
    *)
      echo "Unknown parameter: $1"
      usage
      ;;
  esac
done

# Check required parameters
if [ -z "$url" ] || [ -z "$wordlist" ]; then
  usage
fi

# Fuzz the URL
fuzz_url() {
  local wordlist="$1"
  while IFS= read -r word; do
    response=$(curl -s -o /dev/null -w "%{http_code} %{url_effective}\\n" "$url/$word/")
    code=$(echo "$response" | awk '{print $1}')
    if [[ $code == 200 || $code == 301 || $code == 302 || $code == 403 ]]; then
      echo "$code $url/$word/"
    fi
  done < "$wordlist"
}

# Execute fuzzing
print_banner
fuzz_url "$wordlist"
cat "$wordlist" | xargs -n 1 -P "$threads" bash -c 'fuzz_url "$@"' _
