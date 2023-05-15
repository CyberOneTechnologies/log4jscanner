# Log4J Vulnerability Scanner
## Description
This script helps you to scan and identify if your server or a list of servers is vulnerable to the infamous Log4j (log4shell) vulnerability.

## Installation
Clone this repository to your local machine.

```
git clone https://github.com/CyberOneTechnologies/log4jscanner.git
```

Make the log4jscanner.sh script executable.

```
chmod +x log4jscanner.sh
```

Make sure you have curl installed on your machine. If not, you can install it using the following command.

```
sudo apt-get install curl
```

## Usage
Run the script using the following command.

```
./log4jscanner.sh
```

Follow the prompts to scan a single IP, URL, or a file containing a list of targets.
If desired, generate a report after the scan. The report will be saved as an HTML file.


## vulnreport.html File
This script uses a template HTML file named vulnreport.html to generate the report. The vulnreport.html file should contain the following placeholders:

- **Testing_Company:** This will be replaced by the name of the company doing the testing.
- **Tested_Company:** This will be replaced by the name of the company being tested.
- **TestResults:** This will be replaced by the overall test result status.
- **"<!-- Individual results will be inserted here -->"**: This comment will be replaced by a table containing individual test results.


# Troubleshooting
- If the script is not executing, ensure that you have made it executable using the "**chmod +x log4jscanner.sh**" command.
- Make sure that "**curl**" is installed on your machine.
- If the report is not generated, make sure the "**vulnreport.html**" file exists in the same directory as the script.
- If the report does not contain the correct data, ensure that the placeholders in the "**vulnreport.html**" file match exactly with the ones specified in the Usage section.


##Disclaimer
This tool is meant for educational purposes only. Any misuse of this tool will not be the responsibility of the author. Always get proper authorization before performing any penetration testing.

## Contact
If you have any questions, feel free to contact us.

## License
This project is licensed under the MIT License.
