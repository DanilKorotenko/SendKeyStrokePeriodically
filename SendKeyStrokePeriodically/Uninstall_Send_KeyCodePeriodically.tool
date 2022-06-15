#!/bin/bash

function get_users
{
    local ids=()

    for file in /Users/*; do
        local name="${file##*/}"
        local id=$(dscacheutil -q user | grep name:\ "$name" -A 2 | grep uid | cut -d' ' -f 2)

        if [ ! -z "$id" ]; then
            ids+="$id "
        fi
    done

    echo $ids
}

if [ $EUID != 0 ]; then
    echo "Please, enter sudo password";
    sudo "$0" "$@"
    exit $?
fi

for user_id in $(get_users);
do
    /bin/launchctl bootout gui/${user_id}/com.send-keystroke-periodically-to-verizon-client >/dev/null 2>&1;
done

# Remove plists
rm /Library/LaunchAgents/com.send-keystroke-periodically-to-verizon-client.plist;

# Remove all files
rm -rf /Library/SendKeyStrokeToVerizonClient;

echo "Uninstall done.";
