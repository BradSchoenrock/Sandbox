 
import sys

import datetime
from datetime import timedelta 


NowDate = datetime.datetime.utcnow().strftime("%Y%m%d")
#ThenDate = (datetime.datetime.utcnow() - timedelta(hours=float(sys.argv[1]))).strftime("%Y%m%d")



print (NowDate)
#print (ThenDate)

print (datetime.datetime.now.date)


