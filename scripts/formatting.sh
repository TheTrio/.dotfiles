#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

cols=$(tput cols)

print_middle () {
  string=$1
  len=${#string}
  len=$((len + 2))
  num=$(((cols - len) / 2))
  for i in $(seq $num); do
    printf "#"
  done
  if [ $(((cols-len) % 2)) != 0 ]; then
    num=$((num+1))
  fi
  printf "${Blue} ${string} "
  for i in $(seq $num); do
    printf "${Red}#"
  done
}

print_line () {
  for i in $(seq $cols);do
    printf "${Red}#"
  done
}

print_update () {
  print_line
  print_middle "${1}"
  print_line
  printf "\n\n"
}
