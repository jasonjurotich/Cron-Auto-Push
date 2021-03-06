#!/bin/bash

MY_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

get_user_info() {
    echo -e "What is the path to your local git repository? Provide the full path. \n> \c"
    read LOCAL_REPO
    LOCAL_REPO="${LOCAL_REPO//\//\\\/}" # replaces all / with \/
    replace_string="LOCAL_REPO="\"$LOCAL_REPO\"
    sed -i '3s/.*/'$replace_string'/' auto-push.sh
    echo -e "What is your Github username? \n> \c"
    read USERNAME
    replace_string="USERNAME="\"$USERNAME\"
    sed -i '4s/.*/'$replace_string'/' auto-push.sh
    echo "What is your Github password?"
    echo -e "SECURITY NOTE: This password will be stored in plaintext!!\n> \c"
    read -s PASSWORD
    replace_string="PASSWORD="\"$PASSWORD\"
    sed -i '5s/.*/'$replace_string'/' auto-push.sh
    echo -e "\nWhat is the link to the Github repository you wish to push to? Drop any https:// http:// or www prefixes"
    echo -e "NOTE: Make sure you have push access to this repository!\n> \c"
    read REMOTE_REPO
    REMOTE_REPO="${REMOTE_REPO//\//\\\/}" # replaces all / with \/
    replace_string="REMOTE_REPO="\"$REMOTE_REPO\"
    sed -i '6s/.*/'$replace_string'/' auto-push.sh
    echo -e "What email would you like to have errors sent to? Leave blank if you do not wish to have emails sent. \n> \c"
    read EMAIL 
    replace_string="EMAIL="\"$EMAIL\"
    sed -i '7s/.*/'$replace_string'/' auto-push.sh
}

setup_cron() {
    cron_string="* * * * * "$MY_PATH"/auto-push.sh"
    (crontab -l 2>/dev/null; echo "$cron_string") | crontab -
}


get_user_info
chmod a+x auto-push.sh
setup_cron
