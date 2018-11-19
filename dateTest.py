 
import sys

import datetime
from datetime import timedelta 


NowDate = datetime.datetime.utcnow()
#ThenDate = (datetime.datetime.utcnow() - timedelta(hours=float(sys.argv[1]))).strftime("%Y%m%d")



print (NowDate)
#print (ThenDate)

#print (datetime.datetime.now.date)

midnight = datetime.time(0, 0, 0, 0)

print (midnight)

diff = datetime.timedelta(hours=NowDate.hour, minutes=NowDate.minute, seconds=NowDate.second, microseconds=NowDate.microsecond)

print (diff.total_seconds())
