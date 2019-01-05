#!/bin/env python

import math
import random

a=10000
b=10000
c=10000

sum=0

for i in range(0,a):
    for j in range(0,b):
        randomfloat=random.uniform(1,10)
        randompow=random.uniform(1,10)
        sum+=math.pow(randomfloat, randompow)

print "sum is %s" % sum
