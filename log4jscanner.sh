#! /bin/bash


#	░█████╗░██╗░░░██╗██████╗░███████╗██████╗░░█████╗░███╗░░██╗███████╗
#	██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║██╔════╝
#	██║░░╚═╝░╚████╔╝░██████╦╝█████╗░░██████╔╝██║░░██║██╔██╗██║█████╗░░
#	██║░░██╗░░╚██╔╝░░██╔══██╗██╔══╝░░██╔══██╗██║░░██║██║╚████║██╔══╝░░
#	╚█████╔╝░░░██║░░░██████╦╝███████╗██║░░██║╚█████╔╝██║░╚███║███████╗
#	░╚════╝░░░░╚═╝░░░╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝


# Set color variables for better readability
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
reverse=$(tput rev)
bold=$(tput bold)
reset=$(tput sgr0)

# Check if necessary commands exist
checkCommands() {
    local commands=("curl" "httpx" "assetfinder" "subfinder" "amass")
    for command in "${commands[@]}"; do
        if ! command -v "$command" >/dev/null 2>&1; then
            echo -e "${yellow}${command}${reset} is not installed. Please install it to continue."
            exit 1
        fi
    done
}

# Show help message
showHelp() {
cat << EOF  
${green}
Usage: 
$0 -l httpxsubdomains.txt -b yrt45r4sjyoj19617jem5briio3cs.burpcollaborator.net
$0 -d thecyberone.com -b yrt45r4sjyoj19617jem5briio3cs.burpcollaborator.net

-h, --help              Display help

-l, --url-list          List of domain/subdomain/ip to be used for scanning.

-d, --domain            The domain name to which all subdomains and itself will be checked.

-b, --burpcollabid      Burp collabrator client id address or interactsh domain address.
${reset}
EOF
}

# Domain Scan function
domainScan() {
  echo "Performing domain scan..."
  gau -subs $1 | grep "=" | httpx -silent -mc 200 | grep $2 | anew -q $3
}

# List Scan function
listScan() {
  echo "Performing list scan..."
  cat $1 | httpx -silent -mc 200 | grep $2 | anew -q $3
}



# Main function
main() {
  echo "Log4j Vulnerability Scanner"
  echo "Please select an option:"
  echo "1. Domain Scan"
  echo "2. List Scan"
  read -p "Choice: " choice

  case $choice in
    1)
      read -p "Enter a domain: " domain
      read -p "Enter a pattern to match: " pattern
      read -p "Enter output file: " output
      domainScan $domain $pattern $output
      ;;
    2)
      read -p "Enter a list file: " list
      read -p "Enter a pattern to match: " pattern
      read -p "Enter output file: " output
      listScan $list $pattern $output
      ;;
    *)
      echo "Invalid choice, exiting..."
      exit 1
  esac
}

main

# Parse arguments
while (( "$#" )); do
  case "$1" in
    -h|--help)
      showHelp
      exit 0
      ;;
    -d|--domain)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        domain=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -l|--url-list)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        list=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -b|--burpcollabid)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        burpCollabID=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

# Check if necessary commands exist
checkCommands

# If domain is provided, perform domainScan
if [ -n "$domain" ]; then
    domainScan
fi

# If list is provided, perform listScan
if [ -n "$list" ]; then
    listScan
fi

# If neither domain nor list is provided, show help message
if [ -z "$domain" ] && [ -z "$list" ]; then
    echo "Error: Either a domain or a URL list must be provided."
    showHelp
    exit 1
fi

