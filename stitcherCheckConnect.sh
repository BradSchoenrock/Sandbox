




netstat -anp | egrep "98.12.198.73|98.12.198.72|98.12.198.71"



nslookup csm01twcny | grep -A 3 answer | grep Address | cut -d " " -f 2



${host1/vca[0-9][0-9][0-9]/csm01}
