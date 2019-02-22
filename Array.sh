#!/bin/bash

myList=(10803 11100 34567 11100)

if ! echo $myList | grep -e 12345
then
    myList[3]=12345
fi

myList=($(count=0;while [ "x${myList[count]}" != "x" ];do echo ${myList[count]};count=$(( $count + 1 ));done | tr ' ' '\n' | sort -u))

count=0
while [ "x${myList[count]}" != "x" ]
do
    echo ${myList[count]}
    count=$(( $count + 1 ))
done

#count=0;while [ "x${myList[count]}" != "x" ];do;echo ${myList[count]};count=$(( $count + 1 ));done

