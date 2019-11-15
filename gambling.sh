#!/bin/bash -x

echo "Welcome to Gambling Simulator Program"

STAKE=100
Maxlimit=0
Minlimit=0
DAYS=30
TotalStake=0
VALUE=50

dailyBetAmount=$STAKE
declare -A Dictionary

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
		Dictionary[$counter]=$TotalStake
	else
		TotalStake=$(($TotalStake+$VALUE))
		Dictionary[$counter]=$TotalStake
	fi
  	dailyBetAmount=100
  done
}

limit
betting
echo "now your Stakes : $TotalStake"

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
