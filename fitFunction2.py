
import os
import sys
import datetime
import gc
import math  

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from pandas import DataFrame

from scipy import optimize

def numberSeriesFunc(x, alpha, r, A, B):

    return alpha * ( ( 1-r )**x ) * (1 + A*math.cos(x/30 + B*math.cos(x/30) ) )





x=0.5
alpha = 1
r = 0.2
A=3
B=4


ans = numberSeriesFunc(x, alpha, r, A, B)

print (ans)
