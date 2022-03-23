#!/bin/bash

if [[ "$1" == *"PLAY"* ]]; then
    printf "\n"
    date
    printf "  Found event: %s\n" "$1"
    printf "  Checking state...\n"
    ./amcrest_scheduled_checks.sh -o
fi