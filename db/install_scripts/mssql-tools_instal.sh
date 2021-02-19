#!/bin/bash

# 'set -e' is very important because it cause the shell to exit
# immediately if a simple command exits with a nonzero exit value. A
# simple command is any command not part of an if, while, or until
# test, or part of an && or || list.
set -e 

# Import the public repository GPG keys.
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
# Register the Microsoft Ubuntu repository.
# Enter proper Ubuntu version!!!! (18.04 for bionic?)
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
# Update the sources list
sudo apt-get update 
# install odbc driver
sudo apt-get install unixodbc-dev
# finally install tools (sqlcmd and bcp): 
sudo apt-get install mssql-tools


####################################
# Adding tools directory to $PATH
####################################

# ~/.bashrc is sourced each time terminal is fired
# ~/.bash_profile is sourced at login (startup)
# ~/.profile is sourced at login if: 
#   ~/.bash_profile does not exist and 
#   shell interpreter is bash, but 
#   it is common on other distros
#   it usually sources ~/.bashrc

# The recommended place to define permanent, 
# system-wide environment variables 
# applying to all users is in:
#   /etc/environment

# export - keyword in bash (command in sh)
#          makes changes to variable visable 
#          to child processes

# scripts can be "included" by using:
#   . script_name.sh
#   source script_name.sh

# some links:
#   https://stackoverflow.com/questions/1396066/detect-if-users-path-has-a-specific-directory-in-it
#   https://askubuntu.com/questions/60218/how-to-add-a-directory-to-the-path
#   http://www.troubleshooters.com/linux/prepostpath.htm

case :$PATH: in 
    *:/opt/mssql-tools/bin:*) 
        echo "mssql-tools in PATH"
        ;; 
    *) 
        echo "mssql-tools not in PATH!"

        ADD_THIS='case :$PATH: in *:/opt/mssql-tools/bin:*) ;; *) PATH="$PATH:/opt/mssql-tools/bin" ; export PATH ;; esac'
        TEST_THIS='case :$PATH: in *:/opt/mssql-tools/bin:*)'

        if grep -F $TEST_THIS ~/.bashrc ; then 
            echo '~/.bashrc have addition of mssql-tools to $PATH ' 
        else
            echo 'Adding /opt/mssql-tools/bin to $PATH in ~/.bashrc'
            # echo $ADD_THIS >> ~/.bashrc
            printf "%s" "$ADD_THIS" >> ~/.bashrc
        fi

        if grep -F $TEST_THIS ~/.bash_profile ; then 
            echo '~/.bash_profile have addition of mssql-tools to $PATH ' 
        else
            echo 'Adding /opt/mssql-tools/bin to $PATH in ~/.bash_profile'
            printf "%s" "$ADD_THIS" >> ~/.bash_profile
        fi

        if grep -F $TEST_THIS ~/.profile ; then 
            echo '~/.profile have addition of mssql-tools to $PATH ' 
        else
            echo 'Adding /opt/mssql-tools/bin to $PATH in ~/.profile'
            printf "%s" "$ADD_THIS" >> ~/.profile
        fi

        ;;
esac

echo "Done!"
