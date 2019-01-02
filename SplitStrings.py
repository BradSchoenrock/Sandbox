


import os
import sys
import datetime
import re


st = "hi-there"
string = "hi there"

print (st.split('-',2))
print (string.split('-',2))

data = '''This is a string spanning over multiple lines.
        At somepoint there will be square brackets.

        [like this]

        And then maybe some more text.

        [And another text in square brackets]'''

print ("hey",re.split(r'\[|\]', data))



myString = "2018-11-26T16:42:16.391071+00:00 INFO lsm[2793]: [xid@1192 xid=4VT5yCwizz6 cid=0000055f045b sid=2p5hamgFmq2 name=h5] opening compositor session: g-eBxT7sC8C [CompositorHttp.lambda$open$515]"

splitString = myString.split(" ")

print ("a=",splitString)

moreSplit = splitString[2].split(r'\[|\]')

print ("b=",moreSplit)
