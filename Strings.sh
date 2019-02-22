#!/bin/bash 

string="abcdefghi98.134.78.23jklmnop"

substring='[0-9]+.[0-9]+.[0-9]+.[0-9]+'

echo ${string#substring}
echo ${string##substring}
echo ${string%substring}
echo ${string%%substring}

echo $string | grep -oE $substring

substring="def"

echo ${string#$substring}
echo ${string##$substring}
echo ${string%$substring}
echo ${string%%$substring}
echo ${string/$substring}
