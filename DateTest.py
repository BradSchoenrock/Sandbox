
import os
import sys
from optparse import OptionParser
import time
import datetime
from datetime import date
from datetime import timedelta
import subprocess

   
now = time.gmtime()
  
print ("now = ",now)

dayTime = datetime.datetime(now.tm_year, now.tm_mon, now.tm_mday, now.tm_hour, now.tm_min, now.tm_sec)

print ("dayTime=",dayTime)

yearStr = str(dayTime.year)

print ("yearStr=",yearStr)

yrStr = yearStr

print ("yrStr=",yrStr)

sourceDirRoot = yrStr + ('%.2d%.2d' % (dayTime.month, dayTime.day))
    
print ("sourceDirRoot=",sourceDirRoot)
