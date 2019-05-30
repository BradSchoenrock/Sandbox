#!/bin/bash


currenttime=$(date -u +%H:%M)

echo ${currenttime}

if [[ "$currenttime" > "16:00" ]] && [[ "$currenttime" < "20:00" ]]
then
    echo "in"
else
    echo "out"
fi


