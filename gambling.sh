#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

STAKE=100
VALUE=50
DAYS=30
maxLimit=0
minLimit=0
totalStake=0

declare -A Dictionary

function limit () {
	maxLimit=$(($STAKE+$STAKE*$VALUE/100))
	minLimit=$(($STAKE-$STAKE*$VALUE/100))
}

function betting() {
  for (( counter=1; counter<=$DAYS; counter++ ))
  do
    dailyBetAmount=$STAKE
    while [ $dailyBetAmount -ne 0 ]
    do
	random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then 
		echo "win 1 stake"
		((dailyBetAmount++))
		if [ $dailyBetAmount -eq $maxLimit ]
		then 
			echo "you reach MaxLimit "
			break
		fi
	else
		echo "lose 1 stake"
		((dailyBetAmount--))
		if [ $dailyBetAmount -eq $minLimit ]
		then 
			echo "you reach minLimit"
			break
		fi
	fi
    done
	if [ $dailyBetAmount -eq $minLimit ]
	then
		totalStake=$(($totalStake-$VALUE))
		Dictionary[$counter]=$totalStake
	else
		totalStake=$(($totalStake+$VALUE))
		Dictionary[$counter]=$totalStake
	fi
  	dailyBetAmount=100
  done
	if [ $totalStake -gt 0 ]
	then
		read -p "do you want to countinue 1.Yes 2.No :" toCountinue
		if [ $toCountinue -eq 1 ]
		then
			betting
		fi
	fi
}

function luckyornot(){
	profitValue=$(printf "%s\n" ${Dictionary[@]} | sort -n | tail -1 )
	lossValue=$(printf "%s\n" ${Dictionary[@]} | sort -n | head -1 )

	echo profitValue: $profitValue
	echo lossValue :$lossValue

	echo ${!Dictionary[@]} : ${Dictionary[@]}
	for key in ${!Dictionary[@]}
	do
	if [ ${Dictionary[$key]} -eq $profitValue ]
	then
		echo "lucky day :$key"
	fi

	if [ ${Dictionary[$key]} -eq $lossValue ]
	then
		echo "unlucky day :$key"
	fi
	done
}

function toContinueOrNot() {
		limit
		betting
		luckyornot
}

toContinueOrNot
echo "now your Stakes : $totalStake"
