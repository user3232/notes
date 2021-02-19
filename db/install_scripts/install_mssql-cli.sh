#!/bin/bash
set -e
# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
# Register the Microsoft Ubuntu repository
sudo apt-add-repository https://packages.microsoft.com/ubuntu/18.04/prod
# Update the list of products
sudo apt-get update
# Install mssql-cli
sudo apt-get install mssql-cli
# Install missing dependencies
sudo apt-get install -f
# All done
echo "Done."