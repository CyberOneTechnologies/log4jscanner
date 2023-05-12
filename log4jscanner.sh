#! /bin/bash


#	░█████╗░██╗░░░██╗██████╗░███████╗██████╗░░█████╗░███╗░░██╗███████╗
#	██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║██╔════╝
#	██║░░╚═╝░╚████╔╝░██████╦╝█████╗░░██████╔╝██║░░██║██╔██╗██║█████╗░░
#	██║░░██╗░░╚██╔╝░░██╔══██╗██╔══╝░░██╔══██╗██║░░██║██║╚████║██╔══╝░░
#	╚█████╔╝░░░██║░░░██████╦╝███████╗██║░░██║╚█████╔╝██║░╚███║███████╗
#	░╚════╝░░░░╚═╝░░░╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝



doesCommandExist() {
    command -v "$1" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
      echo -e "$(tput setaf 3)$1 $(tput sgr0)"
    fi
}

domainScan-DoesCommandExistReqText() {
    if [[ $(command -v "curl" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "httpx" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "assetfinder" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "subfinder" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "amass" >/dev/null 2>&1 ; echo $?) -ne 0 ]]; then
      echo -e "\n$(tput setaf 3 ; tput rev ; tput bold) ! Warning ! $(tput sgr0)"      
      echo -e "$(tput setaf 3)Using this feature requires special requirements. It has been detected that the requirements are not installed on your system. $(tput sgr0)"
      echo -e "\n$(tput setaf 3 ; tput bold)Please install these tools: $(tput sgr0)"
    fi
}

domainScan-DoesCommandExistReqExit() {
    if [[ $(command -v "curl" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "httpx" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "assetfinder" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "subfinder" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "amass" >/dev/null 2>&1 ; echo $?) -ne 0 ]]; then
      exit
    fi
}

listScan-DoesCommandExistReqText() {
    if [[ $(command -v "curl" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "httpx" >/dev/null 2>&1 ; echo $?) -ne 0 ]]; then
      echo -e "\n$(tput setaf 3 ; tput rev ; tput bold) ! Warning ! $(tput sgr0)"      
      echo -e "$(tput setaf 3)Using this feature requires special requirements. It has been detected that the requirements are not installed on your system. $(tput sgr0)"
      echo -e "\n$(tput setaf 3 ; tput bold)Please install these tools: $(tput sgr0)"
    fi
}

listScan-DoesCommandExistReqExit() {
    if [[ $(command -v "curl" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "httpx" >/dev/null 2>&1 ; echo $?) -ne 0 ]]; then
      exit
    fi
}

doesCommandExistReqMoreInfo() {
    if [[ $(command -v "curl" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "httpx" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "assetfinder" >/dev/null 2>&1
    ; echo $?) -ne 0 || $(command -v "subfinder" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "amass" >/dev/null 2>&1 ; echo $?) -ne 0 ]]; then
      echo -e "$(tput setaf 3)  - curl $(tput sgr0)"
      doesCommandExist "curl"
      echo -e "$(tput setaf 3)  - httpx $(tput sgr0)"
      doesCommandExist "httpx"
      echo -e "$(tput setaf 3)  - assetfinder $(tput sgr0)"
      doesCommandExist "assetfinder"
      echo -e "$(tput setaf 3)  - subfinder $(tput sgr0)"
      doesCommandExist "subfinder"
      echo -e "$(tput setaf 3)  - amass $(tput sgr0)"
      doesCommandExist "amass"
      echo -e "\n$(tput setaf 3 ; tput bold)You can install the required tools from here: $(tput sgr0)"
      echo -e "$(tput setaf 3)  - curl: https://curl.se/download.html $(tput sgr0)"
      echo -e "$(tput setaf 3)  - httpx: https://github.com/projectdiscovery/httpx#installation $(tput sgr0)"
      echo -e "$(tput setaf 3)  - assetfinder: https://github.com/tomnomnom/assetfinder#install $(tput sgr0)"
      echo -e "$(tput setaf 3)  - subfinder: https://github.com/projectdiscovery/subfinder#installation $(tput sgr0)"
      echo -e "$(tput setaf 3)  - amass: https://github.com/OWASP/Amass#installation $(tput sgr0)"
      exit
    fi
}

while getopts "d:l:b:" OPTION
do
    case $OPTION in
        d)
            DOMAIN=$OPTARG
            domainScan-DoesCommandExistReqText
            domainScan-DoesCommandExistReqExit
            ;;
        l)
            LIST=$OPTARG
            listScan-DoesCommandExistReqText
            listScan-DoesCommandExistReqExit
            ;;
        b)
            BURP=$OPTARG
            ;;
    esac
done

if [[ -z $DOMAIN && -z $LIST || -z $BURP ]]; then
    echo "Please provide a domain (-d) or a URL list (-l) and a burp collaborator ID (-b)"
    doesCommandExistReqMoreInfo
fi
