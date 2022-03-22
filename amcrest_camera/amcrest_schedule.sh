#!/bin/bash

sleepDuration=120
brightness=25

usage() {
    printf "\nUsage: %s\n\n" "$(basename $0)"
    printf "Required env vars:\n"
    printf "  - IPADDRESS: ipaddress of camera\n"
    printf "  - AMCRESTPASSWORD: Amcrest password for camera\n\n"
}

getState() {
    field=$1
    state=$(curl -s --digest -m 5 -u "admin:$AMCRESTPASSWORD" "http://${IPADDRESS}/cgi-bin/configManager.cgi?action=getConfig&name=Lighting" | grep "${field}" | cut -d"=" -f2 | tr -d '[:space:]')
    printf "${state}"

}
getModeState() {
    getState "Mode"
}

getBrightness() {
    getState "MiddleLight"
}

setState() {
    curl -g -s --digest -m 5 -u "admin:$AMCRESTPASSWORD" "http://${IPADDRESS}/cgi-bin/configManager.cgi?action=setConfig&Lighting[0][0].MiddleLight[0].Light=${brightness}"
    curl -g -s --digest -m 5 -u "admin:$AMCRESTPASSWORD" "http://${IPADDRESS}/cgi-bin/configManager.cgi?action=setConfig&Lighting[0][0].Mode=Manual"
}

if [[ -z "${IPADDRESS}" ]] || [[ -z "${AMCRESTPASSWORD}" ]]; then
    usage
    exit 1
fi

for (( ; ; )); do
    date

    mode=$(getModeState)
    brightness=$(getBrightness)

    printf "  Mode: %s, Brightness: %s\n" "${mode}" "${brightness}"

    if [[ "${mode}" != "Manual" ]]; then
        printf "  Detected bad Mode: %s\n" "${mode}"
        printf "  Executing curl command to update Mode to Manual...\n"
        setState

        updatedMode=$(getModeState)
        if [[ "${updatedMode}" != "Manual" ]]; then
            printf "  Mode still not Manual, is: %s\n" "${updatedMode}"
        else
            printf "  Mode successfully updated, is: %s\n" "${updatedMode}"

        fi
    elif [[ "${mode}" == "" ]]; then
        printf "  Mode was blank, CAMERA WENT DOWN (most likely)\n"
    else
        printf "  Mode was not 'SmartLight', was: '%s'\n" "${mode}"
        printf "  Nothing to do\n"
    fi
    printf "  Sleeping for %s\n\n" "${sleepDuration}"
    sleep ${sleepDuration}
done