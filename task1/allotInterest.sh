#!/bin/bash

userfile=$1

if [ -f "${userfile}" ]
then
    echo "Using given accounts file"
else
    userfile=./files/User_Accounts.txt
    echo "Defaulting to files/User_Accounts.txt"
fi

cat $userfile | while read line; do
    row=( $line )
    acc=${row[0]}
    branch=${row[1]}
    cat1=${row[2]}
    cat2=${row[3]}
    cat3=${row[4]}
    totIntRate=0
    intfile=./users/$branch/Daily_Interest_Rates.txt

    while read line2; do
        col=( $line2 )
        currcat=${col[0]}
        rate=${col[1]}
        if [[ $currcat == $cat1 ]]
        then
            totIntRate=`echo $totIntRate ${rate::-1} | awk '{print $1 + $2}'`
        fi
    done <<<$(cat $intfile)

    while read line2; do
        col=( $line2 )
        currcat=${col[0]}
        rate=${col[1]}
        if [[ $currcat == $cat2 ]]
        then
            totIntRate=`echo $totIntRate ${rate::-1} | awk '{print $1 + $2}'`
        fi
    done <<<$(cat $intfile)

    while read line2; do
        col=( $line2 )
        currcat=${col[0]}
        rate=${col[1]}
        if [[ $currcat == $cat3 ]]
        then
            totIntRate=`echo $totIntRate ${rate::-1} | awk '{print $1 + $2}'`
        fi
    done <<<$(cat $intfile)

    userbalfile=./users/$branch/$acc/Current_Balance.txt
    num=( $(cat $userbalfile) )
    newAmt=`echo $totIntRate $num | awk '{print $2 + ($2 * $1)}'`
    > $userbalfile
    echo $newAmt >> $userbalfile
done