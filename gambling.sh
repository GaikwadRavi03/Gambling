#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

STAKE=100
Maxlimit=0
Minlimit=0
DAYS=20
TotalStake=0
VALUE=50

dailyBetAmount=$STAKE

function limit () {
	Maxlimit=$(($dailyBetAmount+$dailyBetAmount*50/100))
	Minlimit=$(($dailyBetAmount-$dailyBetAmount*50/100))
}

function betting() {
  for (( counter=1; counter<=$DAYS; counter++ ))
  do
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
		if [ $dailyBetAmount -eq $Minlimit ]
		then 
			echo "you reach minlimit"
			break
		fi
	fi
    done
	if [ $dailyBetAmount -eq $Minlimit ]
	then
		TotalStake=$(($TotalStake-$VALUE))	
		echo "TotalStake : $TotalStake"
	else
		TotalStake=$(($TotalStake+$VALUE))
		echo "TotalStake : $TotalStake"
	fi
  	dailyBetAmount=100
  done
}

limit
betting
