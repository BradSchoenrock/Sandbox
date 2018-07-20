#!/bin/bash

## CONDOR FILES MAKER FUNCTION ##
function CondorFilesMaker
{
echo "Creating SubMain submit file..."
Universe="Universe = vanilla"
Executable="Executable = /home/schoenr1/JobSumitionScripts/SubMain/SubMainSubmit$1.sh"
Input="Input = /dev/null"
Output="Output= /home/schoenr1/JobSumitionScripts/SubmitOutput/SubmitOutput$1.stout"
Error="Error= /home/schoenr1/JobSumitionScripts/SubmitError/SubmitError$1.sterr"	
Log="Log = /home/schoenr1/JobSumitionScripts/SubmitLog/SubmitLog$1.log"  
ConcLim="Concurrency_Limits = DISK_T3WORK5:100"
Queue="Queue"
echo "${Universe}" > /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$1.submit
echo "${Executable}" >> /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$1.submit
echo "${Input}" >> /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$1.submit
echo "${Output}" >> /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$1.submit
echo "${Error}" >> /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$1.submit
echo "${Log}" >> /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$1.submit
echo "${ConcLim}" >> /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$1.submit
echo "${Queue}" >> /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$1.submit
	
echo "Creating SubMain executable..."
shebang="#!/bin/bash"
export="export HOME="${HOME}""
source1="source ${HOME}/.bashrc"
source2="bash /msu/data/t3work5/schoenr1/Sandbox/test.sh $1"
echo "${shebang}" > /home/schoenr1/JobSumitionScripts/SubMain/SubMainSubmit$1.sh
echo "${export}" >> /home/schoenr1/JobSumitionScripts/SubMain/SubMainSubmit$1.sh
echo "${source1}" >> /home/schoenr1/JobSumitionScripts/SubMain/SubMainSubmit$1.sh
echo "${source2}" >> /home/schoenr1/JobSumitionScripts/SubMain/SubMainSubmit$1.sh

chmod a+x /home/schoenr1/JobSumitionScripts/SubMain/SubMainSubmit$1.sh

}



#Creates main executable
function CondorMainMaker
{
echo "Creating main executable..."

#rm MainSubmit.sh

for n in {1..250}
  do
  condorsubmit="condor_submit /home/schoenr1/JobSumitionScripts/SubMainSubmit/SubMainSubmit$n.submit"

  if [ $n -eq 1 ]
      then
      echo "${condorsubmit}" > MainSubmit.sh
  else
      echo "${condorsubmit}" >> MainSubmit.sh
  fi
  
done

}

for count in {1..250}
  do
  CondorFilesMaker $count
done
CondorMainMaker




#rm /home/schoenr1/JobSumitionScripts/SubmitError/*
#rm /home/schoenr1/JobSumitionScripts/SubmitLog/*
#rm /home/schoenr1/JobSumitionScripts/SubmitOutput/*