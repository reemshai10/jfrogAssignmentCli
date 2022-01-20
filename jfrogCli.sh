#!/bin/bash

#Global Verbs
SERVER_ID=''
URL=''
USER=''
PASS=''

Help()
{
   # Display Help
   echo "This is Reem API for Jfrog artifactory"
   echo
   echo "Syntax: scriptTemplate [-p|-v|-a|-d|-s|-c]"
   echo "options:"
   echo "-p", "--ping","ping the system for health check."
   echo "-v", "--version","Show server version information."
   echo "-a","--add", "add user (prompts for username, email address, and password)."
   echo "-d","--delete","deletes user (prompts for username)."
   echo "-s","--storage","shows the server storage information."
   echo "-c","--config","reconfig user configuration."
   echo
}
if [ -z "$1" ]
  then
    echo "No argument supplied help menu will pop up for instructions:"
    echo
    Help 
fi




while getopts ":pvadsch" opt; do
  case ${opt} in
    p ) 
      jfrog rt ping 
      # jfrog rt curl /api/system/ping  ## we can also do that.
      ;;
    v ) 
      jfrog rt curl /api/system/version
      ;;
    c ) 
      echo "server :"
      read server
      echo "username:"
      read username
      echo "password:"
      read password
      jfrog config add artifactory-server --artifactory-url=$server --user=$username --password=$password --interactive=false
    ;;  
    h ) 
      Help
      exit
      ;;  
    \? ) echo "Error: Invalid option"
         exit
      ;;
  esac
done

