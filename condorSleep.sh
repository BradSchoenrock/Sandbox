#!/bin/bash

a=`condor_q $USER | grep -c $USER`
b=0
while [ $a -ne $b ]
    do
    sleep 5
    a=`condor_q $USER |grep -c $USER`
    done

echo done

