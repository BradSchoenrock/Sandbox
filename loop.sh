#!/bin/bash

for i in {1..186}
do
    num=$((i+5))
    echo "<server host=\"172.20.172.${num}\" port=\"16668\"/>"

done
