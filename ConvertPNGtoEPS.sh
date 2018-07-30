#!/bin/bash

for FILE in *.png
do
    convert $FILE ${FILE%%.*}.eps
done
