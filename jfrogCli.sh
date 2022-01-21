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
   echo "-l","--list","Returns a list of minimal repository details for all repositories of the specified type."
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





while getopts ":pvaudlsch" opt; do
  case ${opt} in
    p ) 
      jfrog rt ping 
      # jfrog rt curl /api/system/ping  ## we can also do that.
      ;;
    v ) 
      jfrog rt curl /api/system/version
      ;;
      d )
      echo "enter the user you want to Delete :"
      read Deluser 
      jfrog rt curl -X DELETE /api/security/users/$Deluser
      ;;
    u ) 
      echo "enter the Repository Key(name) you want to Update :"
      read rk
      echo "enter the new Repository Key(name) you want to be update :"
      read nrk
      jfrog rt curl -X POST \
      /api/repositories/$rk \
      -H 'Accept: application/json' \
      -H 'Content-Type: application/json' \
      -d '{
      "key" : "a2z2q2",
      "rclass" : "local",
      "packageType": "pypi"
    }'
      ;;
    a )
      echo "please enter  username :"
      read username
      echo "please enter  email:"
      read email
      echo "please enter password:"
      read pw
      jo -p username=$username email=$email password=$pw > user.json
      jfrog rt curl -X PUT -H "Content-Type: application/json" -H 'Accept: application/json' -d '{"username":"'$username'","email":"'$email'","password":"'$pw'"}'  /api/security/users/$username 
      jfrog rt curl -X PUT -H "Content-Type: application/json" -H 'Accept: application/json' -d 
    ;;
    l )
      jfrog rt curl /api/repositories
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
    s )
      jfrog rt curl /api/storageinfo
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

