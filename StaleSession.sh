#!/bin/bash

# run this daily. 

proc=$(ps -C html5client -o start,pid,etime,cmd,pcpu,rss,size | grep -)

echo "$(date) Stale Session Detected. process killed. ${proc}" > /var/log/cloudtv-alerts.log

kill -9 $(ps -C html5client -o start,pid,etime,cmd,pcpu,rss,size | grep - | tr -s ' ' | cut -d " " -f 4)


