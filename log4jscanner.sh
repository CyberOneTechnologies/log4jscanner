#! /bin/bash


#	░█████╗░██╗░░░██╗██████╗░███████╗██████╗░░█████╗░███╗░░██╗███████╗
#	██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║██╔════╝
#	██║░░╚═╝░╚████╔╝░██████╦╝█████╗░░██████╔╝██║░░██║██╔██╗██║█████╗░░
#	██║░░██╗░░╚██╔╝░░██╔══██╗██╔══╝░░██╔══██╗██║░░██║██║╚████║██╔══╝░░
#	╚█████╔╝░░░██║░░░██████╦╝███████╗██║░░██║╚█████╔╝██║░╚███║███████╗
#	░╚════╝░░░░╚═╝░░░╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝




doesCommandExist () {
  if ! command -v $1 >/dev/null 2>&1 ; then
    echo "Please install $1"
    return 1
  fi
}

domainScan-DoesCommandExistReqText() {
  echo "The following tools are required for domain scan:"
}

listScan-DoesCommandExistReqText() {
  echo "The following tools are required for list scan:"
}

domainScan-DoesCommandExistReqExit() {
  if [[ $(command -v "curl" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "httpx" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "assetfinder" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "subfinder" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "amass" >/dev/null 2>&1 ; echo $?) -ne 0 ]]; then
    doesCommandExistReqMoreInfo
    exit 1
  fi
}

listScan-DoesCommandExistReqExit() {
  if [[ $(command -v "curl" >/dev/null 2>&1 ; echo $?) -ne 0 || $(command -v "httpx" >/dev/null 2>&1 ; echo $?) -ne 0 ]]; then
    doesCommandExistReqMoreInfo
    exit 1
  fi
}

doesCommandExistReqMoreInfo() {
  echo "You can install the required tools from here:"
  echo "  - curl: https://curl.se/download.html"
  echo "  - httpx: https://github.com/projectdiscovery/httpx#installation"
  echo "  - assetfinder: https://github.com/tomnomnom/assetfinder#install"
  echo "  - subfinder: https://github.com/projectdiscovery/subfinder#installation"
  echo "  - amass: https://github.com/OWASP/Amass#installation"
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
