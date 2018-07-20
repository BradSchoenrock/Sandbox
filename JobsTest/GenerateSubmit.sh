#!/bin/bash

## CONDOR FILES MAKER FUNCTION ##
function CondorFilesMaker
{
echo "Creating SubMain submit file $1 ..."
Universe="Universe = vanilla"
Executable="Executable = /home/schoenr1/Sandbox/JobsTest/SubMain/test$1.sh"
Input="Input = /dev/null"
Output="Output= /home/schoenr1/Sandbox/JobsTest/SubmitOutput/SubmitOutput$1.stout"
Error="Error= /home/schoenr1/Sandbox/JobsTest/SubmitError/SubmitError$1.sterr"	
Log="Log = /home/schoenr1/Sandbox/JobsTest/SubmitLog/SubmitLog$1.log"  	
ConcLim="#Concurrency_Limits = DISK_T3WORK1:40"  
Require="Requirements   = (Machine == \"c-115-4.aglt2.org\")"
Queue="Queue"

echo "${Universe}" > /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
echo "${Executable}" >> /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
echo "${Input}" >> /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
echo "${Output}" >> /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
echo "${Error}" >> /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
echo "${Log}" >> /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
echo "${ConcLim}" >> /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
echo "${Require}" >> /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
echo "${Queue}" >> /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$1.submit
	
echo "Creating SubMain executable $1 ..."
shebang="#!/bin/bash"
export="export HOME="${HOME}""
source1="source ${HOME}/.bashrc"
#source2="bash /home/schoenr1/Sandbox/JobsTest/ttbar-semileptonic/bin/gen_ev.sh $1"
echo "${shebang}" > /home/schoenr1/Sandbox/JobsTest/SubMain/test$1.sh
echo "${export}" >> /home/schoenr1/Sandbox/JobsTest/SubMain/test$1.sh
echo "${source1}" >> /home/schoenr1/Sandbox/JobsTest/SubMain/test$1.sh
echo $2 >> /home/schoenr1/Sandbox/JobsTest/SubMain/test$1.sh

chmod a+x /home/schoenr1/Sandbox/JobsTest/SubMain/test$1.sh

}



#Creates main executable
function CondorMainMaker
{
echo "Creating main executable..."

#rm MainSubmit.sh

n=1
while read Myline
  do 
  condorsubmit="condor_submit /home/schoenr1/Sandbox/JobsTest/SubMainSubmit/test$n.submit"
  if [ $n -eq 1 ]
      then
      echo "${condorsubmit}" > MainSubmit.sh
  else
      echo "${condorsubmit}" >> MainSubmit.sh
  fi
  n=$[n+1]
done < "/home/schoenr1/Sandbox/JobsTest/lines"

}

source2="/home/schoenr1/Sandbox/test.sh"
count=1
while read Myline
  do 
  #echo $count
  source2=$Myline
  CondorFilesMaker $count $source2
  count=$[count+1]
done < "/home/schoenr1/Sandbox/JobsTest/lines"

CondorMainMaker $count



#for count in {1..1}
#  do
#  CondorFilesMaker $count $source2
#done
#CondorMainMaker

#rm /home/schoenr1/Sandbox/JobsTest/SubmitError/*
#rm /home/schoenr1/Sandbox/JobsTest/SubmitLog/*
#rm /home/schoenr1/Sandbox/JobsTest/SubmitOutput/*