

import pylab

def f(x, y):
    return pylab.cos(x) + pylab.sin(y)

xx = pylab.linspace(-5, 5, 100)
yy = pylab.linspace(-5, 5, 100)
zz = pylab.zeros([len(xx), len(yy)])

for i in range(len(xx)):
    for j in range(len(yy)):
        zz[j, i] = f(xx[i], yy[j])

print (type(xx))
print (type(yy))
print (type(zz))
print (len(xx))
print (len(yy))
print (len(zz))
print (len(zz[0]))

pylab.pcolor(xx, yy, zz)
pylab.colorbar()
pylab.show()
