#!/bin/bash

sleepDuration=120
brightness=25

usage() {
    printf "\nUsage: %s\n" "$(basename $0) [-ha]"
    printf "    -h   display usage help\n"
    printf "Required env vars:\n"
    printf "  - IPADDRESS: ipaddress of camera\n"
    printf "  - AMCRESTPASSWORD: Amcrest password for camera\n\n"
}

monitor() {
    curl -N -s --digest -u "admin:$AMCRESTPASSWORD" "http://${IPADDRESS}/cgi-bin/eventManager.cgi?action=attach&codes=\[All\]" | xargs -I{} ./helper_process_event.sh {}
}

if [[ -z "${IPADDRESS}" ]] || [[ -z "${AMCRESTPASSWORD}" ]]; then
    usage
    exit 1
fi

while getopts "h" arg; do
  case $arg in
    h)
      usage
      exit
      ;;
  esac
done

monitor