#!/bin/bash

sleepDuration=10

usage() {
    printf "\n"
    printf "Usage: %s\n\n" "$(basename $0)"
    printf "Required env vars:\n"
    printf "  - IPADDRESS: ipaddress of camera\n"
    printf "  - AMCRESTPASSWORD: ipaddress of camera\n"
    printf "\n"
}

getState() {
    state=$(curl -s --digest -m 5 -u "admin:$AMCRESTPASSWORD" "http://${IPADDRESS}/cgi-bin/configManager.cgi?action=getConfig&name=Lighting" | grep Mode | cut -d"=" -f2 | tr -d '[:space:]')
    printf "${state}"
}

setState() {
    curl -g -s --digest -m 5 -u "admin:$AMCRESTPASSWORD" "http://${IPADDRESS}/cgi-bin/configManager.cgi?action=setConfig&Lighting[0][0].MiddleLight[0].Light=25"
    curl -g -s --digest -m 5 -u "admin:$AMCRESTPASSWORD" "http://${IPADDRESS}/cgi-bin/configManager.cgi?action=setConfig&Lighting[0][0].Mode=Manual"
}

if [[ -z "${IPADDRESS}" ]]; then
    usage
elif [[ -z "${AMCRESTPASSWORD}" ]]; then
    usage
fi

for (( ; ; )); do
    date

    state=$(getState)

    if [[ "${state}" == "SmartLight" ]]; then
        printf "Detected bad value: %s\n" "${state}"
        printf "Executing curl command to update Mode to manual...\n"
        setState

        updatedState=$(getState)
        if [[ "${updatedState}" != "Manual" ]]; then
            printf "state still not Manual, is: %s\n" "${updatedState}"
        else
            printf "state successfully updated, is: %s\n" "${updatedState}"

        fi
    elif [[ "${state}" == "" ]]; then
        printf "State was blank, CAMERA WENT DOWN (most likely)\n"
    else
        printf "State was not SmartLight, was: %s\n" "${state}"
    fi
    printf "sleeping for %s\n\n" "${sleepDuration}"
    sleep ${sleepDuration}
done