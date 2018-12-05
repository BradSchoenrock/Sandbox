'''import sys, select

print ("You have ten seconds to answer!")

i, o, e = select.select( [sys.stdin], [], [], 10 )

if (i):
  print ("You said:", sys.stdin.readline().strip())
else:
  print ("You said nothing!")
'''

import signal
import sys
import readline

def handler(signum, frame):
    print ('\nOperation timed out.')
    exit (99)

# Set the signal handler and a 30-second alarm                                                                         
signal.signal(signal.SIGALRM, handler)
signal.alarm(5)

status = 0

try :
    s = input ('Enter date-of-birth [mm/dd/yyyy]: ')
except KeyboardInterrupt :
    print ('\nKeyboardInterrupt detected.' )
    status = 98
except SystemExit :
    print ('SystemExit detected.' )
    status = 97
except :
    print ('\nException detected: ', str(sys.exc_info()[0]) )
    status = 96
else :
    print ('You entered', s)

signal.alarm(0)          # Disable the alarm.

exit (status)
