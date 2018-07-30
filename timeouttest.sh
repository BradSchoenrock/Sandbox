#!/bin/bash

function doTimeout {
    timeout --foreground 10s bash sleep.sh
}

echo "start"

doTimeout

exVal=$?
echo "exVal="$exVal

if [ $exVal -eq 0 ]; then
    echo "command completed"
elif [ $exVal -eq 124 ]; then
    echo "command timeout"
else
    echo "other exit condition"
fi

echo "end"






