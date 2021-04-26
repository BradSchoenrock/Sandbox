#!/bin/bash  

currDir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) 
scriptName='basename "$0"' source ${currDir}/script_base.sh 
init_stamp=$(date +"%Y-%m-%d %H:%M:%S.%3N") # initial timestamp 
init_name=$(date +"%Y%m%d%H%M%S") # initial timestamp
lvl_chg_size='10000000'				            # in BYTES
logback_file="/etc/tomcat/charter/logback.xml"
log_file="/var/log/tomcat/catalina.out"     # log file to check
curr_log_size=$(stat -c %s ${log_file})	    #centos - get the size of $log_file in bytes
#curr_log_size=$(stat -f %z ${log_file})		#MacOS
curr_log_level=$( grep "root level=" $logback_file | awk -F'"' '{ print $2 }')  #check the current log level setting
new_log_level="0"
email_address="chris.cavazos@charter.com"
#email_address="brad.schoenrock@charter.com,david.ulvestad@charter.com,michelle.clodfelter-elrod@charter.com,narendrababu.kalyanam@charter.com,thejasvi.galla@charter.com,ben.goebel@charter.com,tyson.gray@charter.com,rajesh.kollipara@charter.com,bakhtiyar.syed@charter.com,elizabeth.villanueva@charter.com,chris.cavazos@charter.com"
change_time=""

function check_log_size(){      # function to compare current log size to lvl_chg_size
	if [[ $curr_log_size -le $lvl_chg_size ]]; then
		status_msg "catalina.out is ${curr_log_size} bytes.\n"  # debug line
		status_msg "Log size less than ${lvl_chg_size} bytes, checking rotation.\n" # debug line
		new_log_level="INFO"
		change_log_level BACK
	else
		status_msg "catalina.out is ${curr_log_size} bytes.\n" # debug line
		status_msg "Log size is greater than ${lvl_chg_size} bytes, change to WARN.\n"   # debug line
		new_log_level="WARN"
		change_log_level WARN
	fi
}

function change_log_level(){    # function to change log level to passed variable
	if [[ $1 == $curr_log_level ]]; then
	    status_msg "Current log level, $curr_log_level matches new log level, $new_log_level, no changes made.\n"
	    exit
    else
    	if [[ $1 == WARN ]]; then
    		status_msg "CHANGING TO WARN\n"
    		cp $logback_file ${curr_dir}${init_name}-logback.xml
    		sed -i 's/level="INFO"/level="WARN"/' $logback_file	#Centos	
    		change_time=$(date +"%Y-%m-%d %H:%M:%S.%3N")
    		#sed -i '' 's/level="INFO"/level="WARN"/' $logback_file	#MacOS
    		send_email  
    	elif [[ $1 == INFO ]]; then
    		status_msg "CHANGING TO INFO\n"
    		sed -i 's/level="WARN"/level="INFO"/' $logback_file	#Centos
    		change_time=$(date +"%Y-%m-%d %H:%M:%S.%3N")
    		#sed -i '' 's/level="WARN"/level="INFO"/' $logback_file	#MacOS
    		send_email
    	elif [[ $1 == BACK ]]; then
    		status_msg "CHANGING LOG LEVELS BACK.\n"
            if [[ -f ${last_run}-logback.xml ]]; then
                mv ${curr_dir}${last_run}-logback.xml ${logback_file}
            else
             change_log_level INFO
            fi
	    	change_time=$(date +"%Y-%m-%d %H:%M:%S.%3N")
		    send_email
	    elif [[ $1 == PASS ]]; then
		    status_msg "NO CHANGES MADE\n"
		    change_time="NOC_HANGE"
		    send_email
	    fi
    fi
}

function check_setting(){   # check and print out current log setting
	curr_log_level=$( grep "root level=" $logback_file | awk -F'"' '{ print $2 }')
	status_msg "Log level is currently set to ${curr_log_level}.\n"
}

function send_email(){
    (echo "Subject: Tomcat log level changed on $HOSTNAME to ${new_log_level}
This is a notification email indicating that the Tomcat log level was changed on $HOSTNAME to ${new_log_level} at ${change_time} 
to prevent catalina.out from consuming too much disk space due to excessive DVR logs.
AMS- $HOSTNAME log level change log follows:
"; cat ./mail.log) | /usr/sbin/sendmail $email_address
}

function pre_check(){	# function to check if chef-client is running and move mail.log
	service="chef-client"  
	if [[ $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ]]; then	# grep for $service from ps list, then count lines   
		status_msg "$service is running, exiting.\n"			# if greater than 0, exit
		exit   
	fi
	if [ -f mail.log ]; then		# check if previous mail log exists 
		mv mail.log mail.bak		# move to mail.bak if it exists
	fi
	last_run=$(ls ./ | grep last_ | awk -F"_" '{ print $2 }')
}

function clean_up(){
    rm -f last_* 2> /dev/null 
    touch "last_"${init_name}
}

pre_check
status_msg "Start time is: ${init_stamp}\n" # debug line
check_setting   # debug line
check_log_size
check_setting   # debug line
clean_up
