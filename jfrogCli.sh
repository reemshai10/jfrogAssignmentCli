#!/bin/bash



# this function will config to jfrog artifactory , it will config to artifactory server base on server name and username and password , after it will create a token .
config(){ 
  echo "This is Reem API for Jfrog artifactory"
  echo "Please enter server name :"
  read server
  echo "Please enter username :"
  read username
  echo "Please enter password :"
  read password
  jfrog config add artifactory-server --artifactory-url=$server --user=$username --password=$password --interactive=false # to config cli with jfrog artifactory.
  jfrog rt  access-token-create
}

# Display Help.
helpDesk()
{
   echo "This is helpDesk Cli for Jfrog artifactory"
   echo
   echo "Syntax: scriptTemplate [-p|-v|-a|-l|-d|-s|-c]"
   echo "options:"
   echo "-p", "ping","ping the system for health check."
   echo "-v", "version","Show server version information."
   echo "-a","add", "add user (prompts for username, email address, and password)."
   echo "-d","delete","delete user (prompts for username)."
   echo "-l","list","Returns a list of minimal repository details for all repositories of the specified type."
   echo "-s","storage","shows the server storage information."
   echo "-c","config","reconfig user configuration."
   echo "-h","help","Display Help."
   echo
}
#this function is the cli 
cli()
{
  while getopts ":pvadlsch" opt; do # get the argument from the command .
  case ${opt} in
    p ) 
      jfrog rt ping 
      # jfrog rt curl /api/system/ping  ## we can also do that.
      ;;
    v ) 
      jfrog rt curl /api/system/version  # Show server version information
      ;;
      d )
      echo "Enter the user you want to delete :"
      read Deluser 
      jfrog rt curl -X DELETE /api/security/users/$Deluser # delete the specific user.
      ;;
    a )
      echo "Please enter  username :"
      read username
      echo "Please enter email address :"
      read email
      echo "Please enter password :"
      read pw
      jo -p username=$username email=$email password=$pw > user.json # create a json file
      jfrog rt curl -X PUT -H "Content-Type: application/json" -H 'Accept: application/json' -d @user.json /api/security/users/$username # add user we user json file to send the information.
    ;;
    l )
      jfrog rt curl /api/repositories #Returns a list of minimal repository details for all repositories of the specified type.
      ;;
    c ) 
      echo "Please enter server name :"
      read server
      echo "Please enter username :"
      read username
      echo "Please enter password :"
      read password
      jfrog config add artifactory-server --artifactory-url=$server --user=$username --password=$password --interactive=false # to config cli with jfrog artifactory.
    ;;
    s )
      jfrog rt curl /api/storageinfo #shows the server storage information.
      ;;  
    h ) 
      helpDesk
      exit
      ;;  
    \? ) echo "Error: Invalid option"
         echo
         helpDesk
         exit
      ;;
  esac
done
}


#config # config to jfrog artifactory.
while true 
do
if [ -z "$1" ] # check if any argument enter if not it will show the menu options.
  then
    echo "No argument supplied help menu will pop up for instructions:"
    echo
    helpDesk
    exit 
fi
cli $1
done




