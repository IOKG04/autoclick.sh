#!/usr/bin/env bash

RED='\033[1;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

echo "-- autoclick.sh - ver. 2.2.0 --"
echo " "
echo This specific version of this script was only tested on Arch, should work on other things too though.
echo Ensuring xdotool is installed...

#check if pacman is installed, if it is use it to check if xdotool is instaled and install it if it isn't
#if command -v pacman >/dev/null; then
if which pacman >/dev/null; then
    if ! pacman -Qq | grep -qw xdotool; then
        echo -e "${RED}xdotool not found, installing, this may ask for your password...${NC}"
        sudo pacman -Sy xdotool
    fi
    #check if apt is installed, if it is use it to check if xdotool is instaled and install it if it isn't
    #elif command -v apt >/dev/null; then
    elif which apt >/dev/null; then
    if ! dpkg -l | grep -qw xdotool; then
        echo -e "${RED}xdotool not found, installing, this may ask for your password...${NC}"
        sudo apt-get update
        sudo apt-get install xdotool
    fi
    #if both pacman and apt couldn't be found, report error
else
    echo pacman or apt not found! exiting...
    exit 1
fi

echo "What mouse button would you like pressed?"
echo "1 (left), 2 (middle), or 3 (right). "
read mouse
echo "What should be the delay between button clicks? (In seconds)"
read clock

echo -e "${GREEN}This script will begin in 1 seconds with these settings:${NC}"
echo "Mouse: $mouse  Delay: $clock"
echo -e "Use ${WHITE}[Ctrl-C]${NC} in this terminal to quit."
sleep 1

# The code below is what does the actual clicking.

while [ 1 ]; do
    xdotool click $mouse &
    sleep $clock
done

# The variable $mouse controls what mouse button is pressed.
# The bariable $clock controls how long (in seconds) between each button press.
# Note that it may be difficult to kill this script if the time is too short.
