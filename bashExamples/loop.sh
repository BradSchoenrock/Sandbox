#!/bin/bash
for i in {1..10}
do
sleep 1s
echo "welcome"$i >>~/out.txt
done
