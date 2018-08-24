
import os
import sys
import datetime

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


d = {'a' : 0., 'b' : 1., 'c' : 2.}
pd.Series(d, index=['b', 'c', 'd', 'a'])


df1 = {'one' : pd.Series([1., 2., 3.], index=['a', 'b', 'c']), 'two' : pd.Series([1., 2., 3., 4.], index=['a', 'b', 'c', 'd'])}

df2 = {'three' : pd.Series([6., 7., 8.], index=['a', 'b', 'c']), 'four' : pd.Series([9., 8., 7., 6.], index=['a', 'b', 'c', 'd'])}


df3 = {'hey' : pd.DataFrame(df1), 'listen' : pd.DataFrame(df2)}

print ("d=\n",d)
print ("df1=\n",df1)
print ("df2=\n",df2)
print ("df3=\n",df3)


