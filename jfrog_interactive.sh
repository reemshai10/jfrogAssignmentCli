#!/bin/bash



# this function will config to jfrog artifactory , it will config to artifactory server base on server name and username and password , after it will create a token .
config(){ 
  echo "This is Reem API for Jfrog artifactory"
  echo "Please enter Url ,example:(https://'name'.jfrog.io/artifactory/) :"
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
   echo "options:"
   echo "1", "ping","ping the system for health check."
   echo "2", "version","Show server version information."
   echo "3","add", "add user (prompts for username, email address, and password)."
   echo "4","delete","delete user (prompts for username)."
   echo "5","list","Returns a list of minimal repository details for all repositories of the specified type."
   echo "6","storage","shows the server storage information."
   echo "7","config","reconfig user configuration (if you want to config diffrent server)."
   echo "8","create repository","Creates a new repository in Artifactory"
   echo "9","delete repository repository","delete an existing repository "
   echo "10","upload data to local repository."
   echo "11","download data from local repository."
   echo "12","help","help menu. "
   echo "13","quit","Quit the Cli."
   echo
}



config # call to function to config to jfrog artifactory server
helpDesk # show the cli menu
#echo "You need to chhose option 1-8 :"
PS3='You need to chhose option 1-8 : ' # to select the option 
select=("ping" "version" "delete" "add" "list" "storage" "config" "create" "delete repository" "upload" "download" "help" "quit")
select choose in "${select[@]}"; do # run over and over untill the input is the quit
    case $choose in
        "ping") 
            jfrog rt ping 
        # jfrog rt curl /api/system/ping  ## we can also do that.
            ;;
        "version") 
            jfrog rt curl /api/system/version  # Show server version information
            ;;
        "delete")
            echo "Enter the user you want to delete :"
            read Deluser 
            jfrog rt curl -X DELETE /api/security/users/$Deluser # delete the specific user.
            ;;
        "add")
            echo "Please enter  username :"
            read username
            echo "Please enter email address :"
            read email
            echo "Please enter password :"
            read pw
            jo -p username=$username email=$email password=$pw > user.json # create a json file
            jfrog rt curl -X PUT -H "Content-Type: application/json" -H 'Accept: application/json' -d @user.json /api/security/users/$username # add user we user json file to send the information.  
            ;;
        "list")
            jfrog rt curl /api/repositories #Returns a list of minimal repository details for all repositories of the specified type.
            echo
            ;;
        "storage")
            jfrog rt curl /api/storageinfo #shows the server storage information.
            echo
            ;;
        "config") # if the user want to config anther server . 
            config 
            ;;
        "create") # create a new repository in artifactory.
            echo "Insert the repository key :"
            read key
            echo "Insert the repository package type :"
            read package_type
            mv repository-config.json temp.json  
            jq -r '.key |= "'$key'" | .packageType |= "'$package_type'"' temp.json > repository-config.json
            rm temp.json
            cp repository-config.json repository-config-update.json
            jfrog rt curl -X PUT -H "Content-type:application/vnd.org.jfrog.artifactory.repositories.LocalRepositoryConfiguration+json" -d @repository-config.json /api/repositories/$key 
            ;;
        "delete repository")
              echo "Insert the repository key you want to delete :"
              read key
              jfrog rt curl -X DELETE /api/repositories/$key   
              ;;
        "upload")
              echo "Insert the repository key  :"
              read key
              echo "Insert the file name  :"
              read file
              jfrog rt u $file $key   
              ;;
        "download")
              echo "Insert the repository key  :"
              read key
              echo "Insert the file name  :"
              read file
              jfrog rt dl $key/$file    
              ;;
        "help")
            helpDesk
            ;;
        "quit")
            echo "User requested exit" # the exit the CLI 
            exit
            ;;    
        *) echo "invalid option $REPLY";; # if the user input worng option 
    esac
done




