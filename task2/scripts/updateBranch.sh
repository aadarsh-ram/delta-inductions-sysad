#!/bin/bash

cd users
for i in $(ls -d */)
do
    branch=${i}
    cd ${i}
    touch ${branch::-1}_Current_Balance.txt
    touch ${branch::-1}_Transaction_History.txt
    cp ../../files/Daily_Interest_Rates.txt Daily_Interest_Rates.txt
    currbal=0
    for j in $(ls -d */)
    do
        user=${j}
        cd $user
        num=( $(cat Current_Balance.txt) )
        currbal=`echo $currbal ${num[0]} | awk '{printf "%f", $1 + $2}'` 
        cat ./Transaction_History.txt >> ../${branch::-1}_Transaction_History.txt
        cd ..
    done
    > ./${branch::-1}_Current_Balance.txt
    echo $currbal >> ./${branch::-1}_Current_Balance.txt
    cd ..
done