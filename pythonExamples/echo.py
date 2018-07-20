

a=0.5
b=0.1

lis=[]

for i in range(0, 16):
    for j in range(0,16):
        xif=a + b * i
        xir=a + b * j
        outstr=''
        outstr+='R'
        outstr+=str(xir)
        outstr+='_F'
        outstr+=str(xif)

        lis.append(outstr)
        print outstr
