#!/bin/bash

cols="$(tput cols)"
rows="$(tput lines)"
i=0

rgb() {
	echo "[38;2;$1;$2;$3m"
}

while true; 
do
	title="$(mpc -f %title%)"
	title="${title%%'['*}"
	title="${title%%?}"
	artist="$(mpc -f %artist%)"
	artist="${artist%%'['*}"
	artist="${artist%%?}"
	ltime="$(mpc status %currenttime%)"
	ltm="${ltime##*':'}"
	ltm="${ltm##*'0'}"
	if [[ "$ltm" == "" ]]; then
		ltm="0"
	fi
	ltm="$(( ${ltime%%':'*} * 60 + ${ltm} ))"
	rtime="$(mpc status %totaltime%)"
	rtm="${rtime##*':'}"
	rtm="${rtm##*'0'}"
	if [[ "$rtm" == "" ]]; then
		rtm="0"
	fi
	rtm="$(( ${rtime%%':'*} * 60 + ${rtm} ))"

	n2=$(awk -v cols="$cols" -v l="$ltm" -v r="$rtm" -v tm="$(( ${#ltime} + ${#rtime} + 2 ))" 'BEGIN {printf "%.0f", (cols-tm)*(l/r)}' /dev/null)

	printf "[2J[H[?25l[2G"
	printf "%*s" "$(( ( $cols - ( ${#title} + ${#artist} + 3 )) / 2 - 1))"
	printf "$(rgb 238 212 159)$artist - $(rgb 198 160 246)$title"
	printf "%*s\n" "$(( ( $cols - ( ${#title} + ${#artist} + 3 )) / 2))"
	# printf "$ltime "
	printf "[H[$(( ${rows} - 1 ))B"
	printf "$ltime "
	eval $(echo printf '"█%0.s"' {1..$(( ${n2} - 2 ))}) 
	printf ""
	eval $(echo printf '" %0.s"' {1..$(( $cols - $n2 - ${#ltime} - ${#rtime} - 2 ))}) 
	printf " $rtime"
	printf "[H[1B"
	printf "Hello"

	read -n1 -s -t 0.1 key

	if [[ "$key" == "p" ]]; then
		mpc toggle -q
	elif [[ "$key" == "<" ]]; then
		mpc prev -q
	elif [[ "$key" == ">" ]]; then
		mpc next -q
	elif [[ "$key" == "," || "$key" == "." ]]; then
		if [[ "$key" == "," ]]; then
			key="-"
		else
			key="+"
		fi
		mpc -q volume "$key"5
	elif [[ "$key" == "z" ]]; then
		mpc repeat -q
	elif [[ "$key" == "x" ]]; then
		mpc random -q
	elif [[ "$key" == "c" ]]; then
		mpc consume -q
	elif [[ "$key" == "v" ]]; then
		mpc single -q
	elif [[ "$key" == "f" ]]; then
		mpc -q seek +5
	elif [[ "$key" == "b" ]]; then
		mpc -q seek -5
	fi

	printf "[H[38;2;91;96;120m$key"
done
