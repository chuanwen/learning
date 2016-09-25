#!/bin/bash

# Test a program (executable) against its expected console output.
# Example usage:
# program_test prog1 prog1.expected
#

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color]]'

FileCompare () {
    cmp --silent $1 $2 && echo -e "${GREEN}-- PASS --${NC}: $3" || echo -e "${RED}-- Failed --${NC}: $3"
    return 0
}
program=$1
expected=$2
description=$3

if [[ $(basename "$program") == $program ]]; then
    program=./$program
fi
output=$(mktemp)
$program > $output
rc=$?
if [[ $rc != 0 ]]; then
    echo -e "${RED} Failed to run $program${NC}"
else 
    FileCompare $output $expected "$description"
    rm -f $output
fi
