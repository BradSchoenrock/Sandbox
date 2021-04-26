#!/bin/bash



# restart the local tomcat instance
restartNode () {

        echo "here's where i would have restarted tomcat on $(hostname)"

        # stop/kill old tomcat instances
        psRes=$(ps -ef | grep tomcat | grep -v grep | tr -s " " | cut -d " " -f 2 | sed -n '1 p')
        ittr=0
        while [[ $psRes != "" ]]
        do

                # check uptime of application, rate limit
                time=$(ps $psRes | grep java | tr -s " " | cut -d " " -f 4 | cut -d ":" -f 1)
                if (( $time < 5 )) # 5 min
                then
                        echo "returning: tomcat restarted in last 5 min"
                        return 1
                fi

                # stop tomcat
                #service tomcat stop
                #sleep 5s

                # recheck ps
                psResTmp=$(ps -ef | grep tomcat | grep -v grep | tr -s " " | cut -d " " -f 2 | sed -n '1 p')

                # if service stop didn't work try a sigterm
                if [[ $psResTmp == $psRes ]]
                then
                        sleep .1s
                        # kill 15 SIGTERM
                        #kill -15 $(psRes)
                        #sleep 5s
                fi

                # recheck ps
                psResTmp=$(ps -ef | grep tomcat | grep -v grep | tr -s " " | cut -d " " -f 2 | sed -n '1 p')

                # if sigterm didn't work do a sigkill
                if [[ $psResTmp == $psRes ]]
                then
                        sleep .1s
                        # kill 9 SIGKILL
                        #kill -9 $(psRes)
                        #sleep 5s
                fi

                iter=$(($iter + 1))

                if (( $iter > 10 ))
                then
                        echo "returning: existing tomcat process refuses to die"
                        # return 2
                        break
                fi

                psRes=$(ps -ef | grep tomcat | grep -v grep | tr -s " " | cut -d " " -f 2 | sed -n '1 p')

        done

        # start
        #service tomcat start
        #sleep 5s

        # check status of restart
        nInstances=$(ps -ef | grep tomcat | grep -v grep | wc -l)

        if [[ $nInstances != 1 ]]
        then
                echo "returning: number of tomcat instances is $nInstances not 1"
                return 3
        fi

        MyIP=$(/sbin/ifconfig | grep -A2 eth0 | grep "inet addr" | tr -s " " | cut -d " " -f 3 | cut -d ":" -f 2)

        found=$(curl http://localhost:5701/hazelcast/rest/cluster 2> /dev/null | grep $MyIP)

        if [[ -z $found ]]
        then
                echo "returning: node failed to join hazlecast cluster on restart"
                return 4
        fi

}


#*********************START**********************

# get input mask, 4 binary flags (either 0 or 1) which nodes have been restarted
# 0 means not yet checked, 1 means completed

if [[ -z $1 || $1 != 0 && $1 != 1 ]]
then
        echo "exiting: 1 invalid input, exactly 4 entries (0 or 1) must be provided"
        exit
fi
if [[ -z $2 || $2 != 0 && $2 != 1 ]]
then
        echo "exiting: 2 invalid input, exactly 4 entries (0 or 1) must be provided"
        exit
fi
if [[ -z $3 || $3 != 0 && $3 != 1 ]]
then
        echo "exiting: 3 invalid input, exactly 4 entries (0 or 1) must be provided"
        exit
fi

if [[ -z $4 || $4 != 0  && $4 != 1 ]]
then
        echo "exiting: 4 invalid input, exactly 4 entries (0 or 1) must be provided"
        exit
fi

if [[ ! -z $5 ]]
then
        echo "exiting: 5 invalid input, exactly 4 entries (0 or 1) must be provided"
        exit
fi

NewArray=($1 $2 $3 $4)

echo "start on $hostanme"

for i in ${NewArray[@]}; do echo $i; done

# check existance of nodes in cluster, mask out any not used
for i in {0..3}
do
        if [[ $(nslookup $(echo $(hostname) | sed s/./$(($i+1))/5) | grep Address  | sed -n '2 p' | cut -d " " -f 2) == "" ]]
        then
                NewArray[$i]=1
        fi
done

echo "active check"
for i in ${NewArray[@]}; do echo $i; done


# get host number (ams01 vs ams02 etc...) and position in mask
thisNode=$(hostname | cut -c5-5)
pos=$(($thisNode - 1))



#restart node, update array mask
if (( ${NewArray[${pos}]} == 0 ))
then
        restartNode
        if (( $? != 0 ))
        then
                echo "exiting: restart on this node $hostname failed. returned non zero"
                exit
        fi
        NewArray[${pos}]=1
elif (( ${NewArray[${pos}]} == 1 ))
then
        echo "exiting: Node flagged to not restart"
fi



# find next node to be restarted
nextNode=9

for i in "${!NewArray[@]}"
do
        if (( ${NewArray[$i]} == 0 ))
        then
                nextNode=$(($i+1))
                break
        fi
done
if (( $nextNode == 9 ))
then
        echo "exiting: No remaining nodes"
        for i in ${NewArray[@]}; do echo $i; done
        exit
fi
nameNext=$(echo $(hostname) | sed s/./$nextNode/5)

echo "end"
for i in ${NewArray[@]}; do echo $i; done



# send command to next node
echo "ssh -i ~/.ssh/id_rsa_RollTom $nameNext bash /home/bschoenrock/RollTom.sh ${NewArray[0]} ${NewArray[1]} ${NewArray[2]} ${NewArray[3]}"

ssh -i ~/.ssh/id_rsa_RollTom $nameNext "bash /home/bschoenrock/RollTom.sh ${NewArray[0]} ${NewArray[1]} ${NewArray[2]} ${NewArray[3]}"

echo "Rolling restart of tomcat complete"
