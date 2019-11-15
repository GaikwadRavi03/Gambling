#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

STAKE=100
Maxlimit=0
minlimit=0
dailyBetAmount=$STAKE

function limit () {
	Maxlimit=$(($dailyBetAmount+$dailyBetAmount*50/100))
	minlimit=$(($dailyBetAmount-$dailyBetAmount*50/100))
}

function betting() {
  while [ $dailyBetAmount -ne 0 ]
  do
	random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then 
		echo "win 1 stake"
		((dailyBetAmount++))
		if [ $dailyBetAmount -eq $Maxlimit ]
		then 
			echo "you reach Maxlimit "
			break
		fi
	else
		echo "lose 1 stake"
		((dailyBetAmount--))
		if [ $dailyBetAmount -eq $minlimit ]
		then 
			echo "you reach minlimit"
			break
		fi
	fi
  done
}

limit
betting
echo $dailyBetAmount

