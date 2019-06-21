#!/bin/bash

USERNAME=$(whoami)

host1=$(hostname)
host2=${host1/01/02}
host3=${host1/01/03}

SCRIPT1="netstat -ant | grep 16668[\ ]*ESTABLISHED | tr -s ' ' | cut -d \" \" -f 5 | sort"

netstat -ant | grep 16668[\ ]*ESTABLISHED | tr -s ' ' | cut -d " " -f 5 | sort > out.txt.1
ssh -o StrictHostKeyChecking=no -l ${USERNAME} ${host2} "${SCRIPT1}" > out.txt.2
ssh -o StrictHostKeyChecking=no -l ${USERNAME} ${host3} "${SCRIPT1}" > out.txt.3



diff1=$(diff out.txt.1 out.txt.2 | egrep "<|>" | tr -s ' ' | cut -d " " -f 2 | grep ":" | cut -d ":" -f 1)
diff2=$(diff out.txt.1 out.txt.3 | egrep "<|>" | tr -s ' ' | cut -d " " -f 2 | grep ":" | cut -d ":" -f 1)
diff3=$(diff out.txt.2 out.txt.3 | egrep "<|>" | tr -s ' ' | cut -d " " -f 2 | grep ":" | cut -d ":" -f 1)

SCRIPT="hostname;pwd"
for HOSTNAME in ${diff1};
do
    ssh -o StrictHostKeyChecking=no -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done

for HOSTNAME in ${diff2};
do
    ssh -o StrictHostKeyChecking=no -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done

for HOSTNAME in ${diff3};
do
    ssh -o StrictHostKeyChecking=no -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done

