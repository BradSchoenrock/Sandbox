#!/bin/bash

# run this every 2 min. 


# setting up globals
hostStitch=$(hostname)

# try CSMs 11, 12, 13 (QAM configuration)
hostCSM1=${hostStitch/vca[0-9][0-9][0-9]/csm11}
hostCSM2=${hostStitch/vca[0-9][0-9][0-9]/csm12}
hostCSM3=${hostStitch/vca[0-9][0-9][0-9]/csm13}

# check if you're in a market (reno) where two digit stitcher numbering is used.
if [[ ${hostCSM1} == *"vca"* ]]
then
        hostCSM1=${hostStitch/vca[0-9][0-9]/csm11}
        hostCSM2=${hostStitch/vca[0-9][0-9]/csm12}
        hostCSM3=${hostStitch/vca[0-9][0-9]/csm13}
fi

CSM1=$(echo ${hostCSM1} | cut -d "." -f 1)
CSM2=$(echo ${hostCSM2} | cut -d "." -f 1)
CSM3=$(echo ${hostCSM3} | cut -d "." -f 1)

IPAddrCSM1=$(nslookup ${CSM1} | grep -A 3 answer | grep Address | cut -d " " -f 2)
IPAddrCSM2=$(nslookup ${CSM2} | grep -A 3 answer | grep Address | cut -d " " -f 2)
IPAddrCSM3=$(nslookup ${CSM3} | grep -A 3 answer | grep Address | cut -d " " -f 2)

# check if we are on CSM01 or CSM11
if [ ${IPAddrCSM1} == "" ]
then

        hostCSM1=${hostStitch/vca[0-9][0-9][0-9]/csm01}
        hostCSM2=${hostStitch/vca[0-9][0-9][0-9]/csm02}
        hostCSM3=${hostStitch/vca[0-9][0-9][0-9]/csm03}

        # check if you're in a market (reno) where two digit stitcher numbering is used.
        if [ ${hostCSM1} == "*vca*" ]
        then
                hostCSM1=${hostStitch/vca[0-9][0-9]/csm01}
                hostCSM2=${hostStitch/vca[0-9][0-9]/csm02}
                hostCSM3=${hostStitch/vca[0-9][0-9]/csm03}
        fi

        CSM1=$(echo ${hostCSM1} | cut -d "." -f 1)
        CSM2=$(echo ${hostCSM2} | cut -d "." -f 1)
        CSM3=$(echo ${hostCSM3} | cut -d "." -f 1)

        IPAddrCSM1=$(nslookup ${CSM1} | grep -A 3 answer | grep Address | cut -d " " -f 2)
        IPAddrCSM2=$(nslookup ${CSM2} | grep -A 3 answer | grep Address | cut -d " " -f 2)
        IPAddrCSM3=$(nslookup ${CSM3} | grep -A 3 answer | grep Address | cut -d " " -f 2)

fi


#********************
# check function to determine CSM stitcher connectivity
check () {

        thing1=$(netstat -anp | grep "${IPAddrCSM1}" | wc -l)
        thing2=$(netstat -anp | grep "${IPAddrCSM2}" | wc -l)
        thing3=$(netstat -anp | grep "${IPAddrCSM3}" | wc -l)

        if [ ${thing1} != 1 ]
        then
                return 0
        fi

        if [ ${thing2} != 1 ]
        then
                return 0
        fi

        if [ ${thing3} != 1 ]
        then
                return 0
        fi

        return 1

}

#****************

# check every 10 sec for 2 min.
for i in {1..12}
do
        sleep 10s
        if check
        then
                :
        else
                exit
        fi
done

# **************
# check CSM health, if CSMs are having problems don't restart stitchers
curl1=$(curl -s http://${IPAddrCSM1}:9099/cluster?cmd=checkRunning | grep -i healthy | wc -l)
curl2=$(curl -s http://${IPAddrCSM2}:9099/cluster?cmd=checkRunning | grep -i healthy | wc -l)
curl3=$(curl -s http://${IPAddrCSM3}:9099/cluster?cmd=checkRunning | grep -i healthy | wc -l)

if [ ${curl1} != 1 ]
then
        exit
fi

if [ ${curl2} != 1 ]
then
        exit
fi

if [ ${curl3} != 1 ]
then
        exit
fi

# *********************
# ok now restart stitcher

thing1=$(netstat -anp | grep "${IPAddrCSM1}" | wc -l)
thing2=$(netstat -anp | grep "${IPAddrCSM2}" | wc -l)
thing3=$(netstat -anp | grep "${IPAddrCSM3}" | wc -l)

echo "$(date) detected CSM-Stitcher connectivity loss. Restarting stitcher to re-establish connection." > /var/log/cloudtv-alerts.log

echo "Subject: test CSM-Stitcher Connectivity loss detected
h5restartall automatically performed.
stitcher- $(hostname)
${thing1} connections to CSM1
${thing2} connections to CSM2
${thing3} connections to CSM3
" | /usr/sbin/sendmail brad.schoenrock@charter.com,david.ulvestad@charter.com,michelle.clodfelter-elrod@charter.com,narendrababu.kalyanam@charter.com,thejasvi.galla@charter.com,ben.goebel@charter.com,tyson.gray@charter.com,rajesh.kollipara@charter.com,bakhtiyar.syed@charter.com,elizabeth.villanueva@charter.com

# stop services, wait, then restart
h5restartall


