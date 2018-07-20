#!bin/bash


let n=01

max=10000

while read line
  do
  #echo $line>>outfile.txt;

  echo $line>>inputFiles$n.txt
  let n=n+1
  
  #echo ${line:49:92}
  #echo ${line:141:33}
  #echo $line $n
  echo $n
done<"inputFiles.txt"


echo $value;
    
