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

domainScan() {
    # Domain scan logic here...
    echo "Performing domain scan..."
    echo "$domain" | assetfinder --subs-only | httpx -silent -content-length -title -status-code -mc 200,301,302,307,308,403,401,405,406,500,501,502,503 -follow-redirects -vhost -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3' -H 'Referer: https://www.google.com/' -H 'Connection: close' -H 'Upgrade-Insecure-Requests: 1' -H 'Accept: */*' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'Cache-Control: max-age=0' -H 'Content-Type: text/plain' -timeout 3 -retries 2 -threads 300 | anew | grep -E '\[200\]|\[301\]|\[302\]|\[307\]|\[308\]|\[403\]|\[401\]|\[405\]|\[406\]|\[500\]|\[501\]|\[502\]|\[503\]' | sort -u
}

listScan() {
    # List scan logic here...
    echo "Performing list scan..."
    cat $list | httpx -silent -content-length -title -status-code -mc 200,301,302,307,308,403,401,405,406,500,501,502,503 -follow-redirects -vhost -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3' -H 'Referer: https://www.google.com/' -H 'Connection: close' -H 'Upgrade-Insecure-Requests: 1' -H 'Accept: */*' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'Cache-Control: max-age=0' -H 'Content-Type: text/plain' -timeout 3 -retries 2 -threads 300 | anew | grep -E '\[200\]|\[301\]|\[302\]|\[307\]|\[308\]|\[403\]|\[401\]|\[405\]|\[406\]|\[500\]|\[501\]|\[502\]|\[503\]' | sort -u
}

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

