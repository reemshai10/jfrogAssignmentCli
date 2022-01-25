# artifactory-cli
CLI for [JFrog Artifactory](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI)

## Setup
to run this script your need to download jo and jq .
we use mac.

use the terminal command line.
About abcde : JSON output from a shell!
More Information: https://github.com/jpmens/jo
Steps:

1. Launch Terminal by pressing command+space, type terminal and hit Enter key.
2. Run
   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
3. Install
   brew install jo

4. brew install jq

5. Done!

Then make yourself familiar with available cli options by running:   ./jfrog_interactive.sh

just run the bash scirpt, after config your server , and use the cli .

if any time your want to see the cli menu just command empty enter . 


## To do
Please write a command line interface in Python or Bash to manage an Artifactory SaaS instance via its API. You can register one for free here : https://jfrog.com/start-free/#saas .


- Features - done 6.
  Please implement at least five of the following APIs, with at least one example of each HTTP verb:

  ● System Ping

  ● System Version

  ● Create User

  ● Delete User

  ● Get Storage Info

  ● Create Repository

  ● Update repository

  ● List repositories

- Authenticate - done
  - Run the APIs against Artifactory with a token, but base the CLI login on user/password.
  - Provide us with a user+password for initial usage of the CLI wth your instance.
- General Guidelines

  ● Upload the final CLI package/zip to your Artifactory in a local repository and allow easy installation from it.

  ● Have a help menu displaying all the functions and usage.

  ● This is an ״open-book״ test, so feel free to use search engines but don't copy your work
    from pre-existing public solutions.

  ● Omission of some features or details is acceptable - our shared goal is for you to
    showcase your skills to the best of your ability and submit a solution you’re proud of.

  ● Please write documentation of the sources used, as well of the decisions made during the
    assignment.

  ● All code should be hosted in a public git repository.
- Save token - Done
- System Ping - Done
- System Version - Done
- Create User - Done
- Delete User - Done
- Get Storage Info - Done
- Create Repository - Done
- delete repository - Done
- upload data to repository - Done
- download data from repository - Done