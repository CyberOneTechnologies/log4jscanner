# **Log4j Vulnerability Scanner**

This repository contains a shell script to check for the Log4j vulnerability. It can scan a single IP address, a single URL, or multiple targets listed in a file.

## **Setup**

1. **Clone the repository:**
    ```
    git clone https://github.com/CyberOneTechnologies/log4jscanner.git
    ```
	
2. **Navigate to the cloned directory:**
    ```
    cd log4jscanner
    ```
	
3. **Make the script executable:**
    ```
    chmod +x log4jscanner.sh
    ```


## **Usage**

**Run the script and follow the prompts:**
    ```
./log4jscanner.sh
    ```



# Guide

When you run the script, you will be prompted with three options:

**1) Enter an IP Address to test**<br>
**2) Enter a URL to test**<br>
**3) Enter a file of targets to test**<br>
**For option 3, you should provide the full path to the file (format: /folder/file.txt).**<br>

## Dependencies
This script uses curl to send requests. Please ensure you have it installed on your system.

# Troubleshooting
If you encounter issues when running the script:

Ensure that curl is installed and accessible in your system PATH.
Verify that the targets are reachable and that your network allows outbound HTTP/HTTPS requests.
Check the format of your input. If you are using a file for the targets, ensure it is formatted correctly with one target per line.
Important Notice
This script is a basic demonstration and might not identify all instances of the Log4j vulnerability. Please use more sophisticated tools and methods for a comprehensive security assessment.

Always run this script on systems you have permission to scan. Unauthorized scanning can be considered illegal.

This script doesn't remediate the vulnerability. If you find a server that is vulnerable, immediately apply patches or other mitigations.

# License
This project is licensed under the MIT License - see the LICENSE.md file for details.

This revised `README.md` includes bold fonts, headers at different levels, and a new troubleshooting section. As before, replace the GitHub URL with your actual repository URL, and update the license information if you're using a different license.
