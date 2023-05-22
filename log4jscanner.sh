#! /bin/bash

####################################################################################
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░Log4J Scanner░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░Developed by Aarsyth░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░░░░░░░░░░░░GitHub Repository: https://github░com/CyberOneTechnologies/░░░░░░░░░░░#
#░░░░░░░░░░░░░░░░░For support, reach out on Discord: Aarsyth#0563░░░░░░░░░░░░░░░░░░#
####################################################################################
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░░░░░░░░█████╗░██╗░░░██╗██████╗░███████╗██████╗░░█████╗░███╗░░██╗███████╗░░░░░░░░░#
#░░░░░░░██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║██╔════╝░░░░░░░░░#
#░░░░░░░██║░░╚═╝░╚████╔╝░██████╦╝█████╗░░██████╔╝██║░░██║██╔██╗██║█████╗░░░░░░░░░░░#
#░░░░░░░██║░░██╗░░╚██╔╝░░██╔══██╗██╔══╝░░██╔══██╗██║░░██║██║╚████║██╔══╝░░░░░░░░░░░#
#░░░░░░░╚█████╔╝░░░██║░░░██████╦╝███████╗██║░░██║╚█████╔╝██║░╚███║███████╗░░░░░░░░░#
#░░░░░░░░╚════╝░░░░╚═╝░░░╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝░░░░░░░░░#
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
####################################################################################
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
####################################################################################
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░Description:░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#----------------------------------------------------------------------------------#
#░This script is used to check for Log4j vulnerability in target systems. It░░░░░░░#
#░provides a menu-based interface to select the target selection method (IP░░░░░░░░#
#░address, URL, or file) and performs vulnerability checks for each target. It░░░░░#
#░generates a report with the results, allowing the user to specify the tested░░░░░#
#░company and testing company names. The report is saved in HTML format with a░░░░░#
#░timestamp in the filename.░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░Features:░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#----------------------------------------------------------------------------------#
#░- Menu-based interface for selecting the target selection method.░░░░░░░░░░░░░░░░#
#░- Ability to check for Log4j vulnerability in IP addresses, URLs, or a list of░░░#
#░░░targets from a file.░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░- Color-coded output for better readability (red for vulnerable, green for safe,░#
#░░░and yellow for status updates).░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░- Generates an HTML report with individual target results.░░░░░░░░░░░░░░░░░░░░░░░#
#░- Customizable report template (using the "vulnreport.html" file) with░░░░░░░░░░░#
#░░░placeholders for the tested and testing company names.░░░░░░░░░░░░░░░░░░░░░░░░░#
#░- Displays the overall test result status (pass, fail, or error) at the end of░░░#
#░░░the report.░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░- Option to generate or skip the report based on user input.░░░░░░░░░░░░░░░░░░░░░#
#░- Error handling for invalid options or errors during the vulnerability checks.░░#
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░Let's get started!░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░#
####################################################################################



# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

# Function to check for Log4j vulnerability
check_log4j () {
    result=$(curl --silent --max-time 10 --insecure --data-urlencode "${1} \${jndi:ldap://127.0.0.1:1389/Exploit}" "${2}" | grep -q "java.lang.NoClassDefFoundError" && echo "vulnerable" || echo "safe")
    echo $result
}

# Prompt for target selection method
echo "Please select the target selection method:"
echo "1) Enter an IP Address to test?"
echo "2) Enter a URL to test?"
echo "3) Enter a file of targets to test?"

read option

targets=()

if [ $option -eq 1 ]; then
    echo "Enter the IP Address:"
    read ip
    targets+=("$ip")
elif [ $option -eq 2 ]; then
    echo "Enter the URL:"
    read url
    targets+=("$url")
elif [ $option -eq 3 ]; then
    echo "Post the location of the file for the targets: (format: /folder/file.txt)"
    read file
    while IFS= read -r line; do
        targets+=("$line")
    done < "$file"
else
    echo -e "${RED}Invalid option. Exiting...${NC}"
    exit 1
fi

# Array to store results
results=()

# Loop over all targets and check for Log4j vulnerability
for target in "${targets[@]}"; do
    echo -e "${YELLOW}Checking target $target...${NC}"
    result=$(check_log4j "\${jndi:ldap://127.0.0.1:1389/Exploit}" "$target")
    if [ "$result" == "vulnerable" ]; then
        echo -e "${RED}$target is vulnerable to Log4j.${NC}"
        results+=("fail")
    elif [ "$result" == "safe" ]; then
        echo -e "${GREEN}$target is not vulnerable to Log4j.${NC}"
        results+=("pass")
    else
        echo -e "${RED}Error checking $target.${NC}"
        results+=("error")
    fi
done

# Ask if user wants to generate a report
echo "Would you like to generate a report? (Y/N)"
read generate_report

if [[ "$generate_report" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Enter the name of the company being tested:"
    read tested_company
    echo "Enter the name of the company doing the testing:"
    read testing_company

    # Generate a timestamp
    timestamp=$(date +%Y%m%d%H%M%S)
    # Include the company name and timestamp in the report filename
    report_file="${tested_company}_log4j_report_${timestamp}.html"

    cp vulnreport.html $report_file

    sed -i "s/Testing_Company/$testing_company/g" "$report_file"
    sed -i "s/Tested_Company/$tested_company/g" "$report_file"

# Insert individual results into the report
for target in "${!targets[@]}"; do
    status=${results[$target]}
    sed -i "/<!-- Individual results will be inserted here -->/a <tr><td>${targets[$target]}</td><td>$status</td></tr>" "$report_file"
done

# Test result status
if [[ " ${results[@]} " =~ "fail" ]]; then
    sed -i 's|<span id="TestResults"></span>|<span id="TestResults" style="font-size: 2em; background-color: darkred; color: white;">Fail</span>|g' "$report_file"
elif [[ " ${results[@]} " =~ "error" ]]; then
    sed -i 's|<span id="TestResults"></span>|<span id="TestResults" style="font-size: 2em; background-color: orange; color: black;">Error</span>|g' "$report_file"
else
    sed -i 's|<span id="TestResults"></span>|<span id="TestResults" style="font-size: 2em; background-color: green; color: black;">Pass</span>|g' "$report_file"
fi

echo -e "${GREEN}Report has been generated and saved to $report_file.${NC}"
elif [[ "$generate_report" =~ ^([nN][oO]|[nN])$ ]]; then
    echo -e "${GREEN}No report will be generated.${NC}"
else
    echo -e "${RED}Invalid option. Exiting...${NC}"
    exit 1
fi

