
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

def timeSeriesFunc(x, alpha, beta, gamma, mu1, mu2, mu3, sig1, sig2, sig3, A, B, C):

    inter1= alpha/sig1 * math.exp( (-1*(x-mu1)**2) / (2*sig1**2) )
    inter2= beta/sig2 * math.exp( (-1*(x-mu2)**2) / (2*sig2**2) )
    inter3= gamma/sig3 * math.exp( (-1*(x-mu3)**2) / (2*sig3**2) )
    inter4= 1 + A*math.cos( x/30 + B*math.cos( x/30 ) )

    
    return 1/math.sqrt(2*math.pi) * ( inter1 + inter2 + inter3 ) * ( inter4 ) + C



x=1
alpha=2
beta=3
gamma=4
mu1=5
mu2=6
mu3=7
sig1=8
sig2=9
sig3=10
A=11
B=12
C=13

ans=timeSeriesFunc(x, alpha, beta, gamma, mu1, mu2, mu3, sig1, sig2, sig3, A, B, C)

print (ans)


