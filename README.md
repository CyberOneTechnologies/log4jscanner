# Log4J Scanner

This script, `log4jscanner.sh`, is a bash script designed to scan for potentially vulnerable log4j instances. The script takes a domain or a list of URLs as input and performs a scan to detect potential vulnerabilities.

## Installation

To install and use this script, first clone the repository from Github:

```
git clone https://github.com/CyberOneTechnologies/log4jscanner.git
```

This command will create a new directory log4jscanner with the script log4jscanner.sh inside it.

## Dependencies
The script requires the following utilities:

* curl
* gau
* httpx
* anew

Please ensure these utilities are installed and accessible in your PATH.

### Install Dependancies 
You can install the dependancies on Kali or Debian system with the following commands.

```
sudo apt install getallurls -y && sudo aptitude install subfinder -y && sudo apt install httpx-toolkit -y
```

# Install Golang
To install anew you need to first install Golang

## First, install the package
sudo apt install -y golang

### Then add the following to your .bashrc
edit your .bashrc file - located in your home directory. "sudo nano ~/.bashrc"

```
export GOROOT=/usr/lib/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
```

### Reload your .bashrc

```
source .bashrc
```


Install the program "anew"

```
sudo git clone https://github.com/tomnomnom/anew.git
```



Change to the new directory

```
cd anew
```

Install with Golang

```
go build -buildvcs=false
```

Move the anew file to the bin directory so it is in the path folder

```
sudo mv anew /usr/local/bin/
```




## Usage
Navigate to the cloned repository:

```
cd log4jscanner
```

Make the script executable:

```
chmod +x log4jscanner.sh
```

To scan a specific domain:

```
./log4jscanner.sh -d example.com
```

To scan a list of URLs:

```
./log4jscanner.sh -l url_list.txt
```

To use with Burp Collaborator:

```
./log4jscanner.sh -d example.com -b your_burpcollabid
```


## Help

For more information, you can display the help message with:

```
./log4jscanner.sh -h
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License - see the *LICENSE.md* file for details. Please note that this license is intended for private use only.
