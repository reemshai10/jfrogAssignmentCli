# artifactory-cli
CLI for [JFrog Artifactory](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI)

## Setup
to run this script your need to download jo and jq .

This script runs on mac dependencies

use the terminal command line.

1. Launch Terminal and click enter.

2. brew install jfrog-cli

About abcde : JSON output from a shell!
More Information: https://github.com/jpmens/jo
Steps:

3. Run
   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
4. Install
   brew install jo

5. brew install jq

6. Done!

Then make yourself familiar with available cli options by running:   ./jfrog_interactive.sh

just run the bash scirpt, the first thing you need is the config to jfrog artifactory server, you need to enter server url , username, password  .
the scrpit also generate accsess-token.
after you get a output of the accsess-key is mean you success to config.
you will see the menu of the cli, and you able to start use it.


if any time your want to see the cli menu just command empty enter . 
Or run number in the cli. 




JFROG CLI CHEAT SHEET

https://media.jfrog.com/wp-content/uploads/2021/03/30185137/JFrogCLICheatSheet.pdf