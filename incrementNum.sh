#!/bin/bash


number=1

yes="number$number/"

for i in 1 2 3
do
    echo $number
    yes="number$number/"
    echo $yes

    ((number++))

done
