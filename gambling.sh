#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

STAKE=100

dailyBetAmount=$STAKE

function betting() {
	random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then 
		echo "win 1 stake"
		((dailyBetAmount++))
	else
		echo "lose 1 stake"
		((dailyBetAmount--))
	fi
}

betting
echo $stake
