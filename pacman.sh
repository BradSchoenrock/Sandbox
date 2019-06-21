#!/bin/bash

myList=()

#compares the snmp info to the netstat result to determine number of streams going out
compare () {
	varone=$(snmpget -v2c -c public localhost 1.3.6.1.4.1.1192.1.1.1.4.0 | sed -n 's/.*Gauge32: \(.*\)$/\1/p')
	vartwo=$(netstat -nputw | grep udp | grep compositor | sort | grep -v 127.0.0 | wc -l)

	#echo "snmp reports $varone"
	#echo "netstat reports $vartwo"

	if [ $varone -lt $vartwo ]
	then
        	return 0
	else
		return 1
	fi
}

# checks current netstat list to last netstat list and keeps only sessions that were previously active
# to let us know if there is a single continuous session. If the list gets to zero length (has no entries)
# program will exit. Checks if entries are in list by checking for a ":" character, which seperates 
# port and IP in  
writeList () {
	#echo "hey"
		
	netstatResult=$(netstat -nputw | grep udp | grep compositor | sort | grep -v 127.0.0 | tr -s ' ' | cut -d " " -f 5)
	#echo "before loop"
	#echo $netstatResult
	tmplist=()
	for entry in $netstatResult
	do
		#echo "entry=$entry"
		for entry2 in $myList
		do
			#echo "entry2=$entry2"
			if [ ${entry} == ${entry2} ]
			then
				#echo "equal"
				tmplist+="${entry} "
			fi
		done
	done
	myList=$tmplist
	tmpStr=":"
	if [[ ${myList} != *${tmpStr}* ]]
	then
		#echo "exiting"
		#echo $myList	
		exit
	fi
	
}

###################start###################

# initial setup of myList which holds list of IP Ports being broadcast
myList=$(netstat -nputw | grep udp | grep compositor | sort | grep -v 127.0.0 | tr -s ' ' | cut -d " " -f 5)

#echo $myList

# run once per min for 30 min. Exit if snmp and netstat match. 
for i in {1..30}
do
	#echo "start of itteration"
	if compare
	then
		writeList
		#echo "myList:"
		#echo $myList
		sleep 1m
	else
		exit
	fi	
done

# check time of day, if between 15:00 and 21:00 UTC (9-3 mountain time) do automatic restarts. 
# log and emails sent here to inform team of any action taken or detection outside of restart hours. 
# 9-3 was settled upon since ghost sessions spawn at night, and we don't want to restart in PT. 
# known problem where snmp over-reports the number of sessions may lead to missing ghost sessions. 
currenttime=$(date +%H:%M)
if [[ "$currenttime" > "15:00" ]] && [[ "$currenttime" < "21:00" ]]
then
	echo "$(date) pacman detected a ghost session. snmpwalk reports $varone active streams. netstat reports $vartwo active streams.Port & IP of ghost - ${myList}. h5restartall automatically performed." > /var/log/cloudtv-alerts.log
	echo "Subject: pacmanV6 test ghost stream detected
pacman detected a ghost session and an h5restartall automatically performed. 
stitcher- $(hostname)
snmpwalk reports $varone active streams
netstat reports $vartwo active streams
port & IP - ${myList}
       ,--.       ,--.  
      |oo  | _  \\  \`.
o  o|~~ |(_) /   ; 
      |/\\/\\|      '._,' 
" | /usr/sbin/sendmail brad.schoenrock@charter.com,david.ulvestad@charter.com,michelle.clodfelter-elrod@charter.com,narendrababu.kalyanam@charter.com,thejasvi.galla@charter.com,ben.goebel@charter.com,tyson.gray@charter.com,rajesh.kollipara@charter.com,bakhtiyar.syed@charter.com,elizabeth.villanueva@charter.com
	h5restartall
else
	echo "$(date) pacman detected a ghost session. snmpwalk reports $varone active streams. netstat reports $vartwo active streams.Port & IP of ghost - ${myList}. No automatic action taken." > /var/log/cloudtv-alerts.log
	echo "Subject: pacmanV6 test ghost stream detected
pacman detected a ghost session outside of automatic restart times. No automatic action taken. 
stitcher- $(hostname)
snmpwalk reports $varone active streams
netstat reports $vartwo active streams
port & IP - ${myList}
       ,--.       ,--.  
      |oo  | _  \\  \`.
o  o|~~ |(_) /   ; 
      |/\\/\\|      '._,' 
" | /usr/sbin/sendmail brad.schoenrock@charter.com,david.ulvestad@charter.com,michelle.clodfelter-elrod@charter.com,narendrababu.kalyanam@charter.com,thejasvi.galla@charter.com,ben.goebel@charter.com,tyson.gray@charter.com,rajesh.kollipara@charter.com,bakhtiyar.syed@charter.com,elizabeth.villanueva@charter.com
fi

sendmail -q

