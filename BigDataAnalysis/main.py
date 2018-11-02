#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 17 12:08:04 2018

@author: akshay1109
"""

# Necessary library inputs
import sys
from collections import OrderedDict, defaultdict
import collections
import csv
import re
import keras
import tensorflow
import theano
from itertools import groupby 
import numpy as np
import pandas as pd
import os
from random import randint
import matplotlib.pyplot as plt
from pylab import figure

with open('syslog.txt', 'r') as input_file:
    lines = input_file.read().splitlines()
    stripped = [line.replace(","," ").split() for line in lines]
    grouped = zip(*[stripped]*1)
    with open('log.csv', 'w') as output_file:
        writer = csv.writer(output_file)
        writer.writerow(('Date','','TIme','Service','Group','Message'))
        for group in grouped:
            writer.writerows(group)

"""     
with open("log.csv","rb") as source:
    reader = csv.reader(source)
    with open ("log1.csv","wb") as result:
        writer = csv.writer(result)
        for row in reader:
"""

"""
with open("log.csv","rt") as source:
    rdr= csv.reader( source )
    with open("result","wb") as result:
        wtr= csv.writer( result )
        for r in rdr:
            print("Adding merged COL1/COL2 into one column for every row...")
            wtr.writerow(r+[r[0] + ' ' + r[1]])
            print("Deleting COL1/COL2 columns from every row...")
            del r[0]https://stackoverflow.com/questions/24313407/match-string-in-python-regardless-of-upper-and-lower-case-differences#
            del r[0]
            wtr.writerow( r )
    result.close();
"""

"""
with open('log.csv','r') as in_file:
    reader = csv.DictReader(in_file)
    for line in reader:
        arrival = "{}, {}".format(line[0], line[1])
"""

"""
array_list = []
with open('log.csv','r') as array_input:
    for line in array_input:
        array_input = array_input.split(',')
        print(array_input)
"""


error = input("What stats you want to look at ? ")
p = re.compile(error, flags=re.IGNORECASE)
q = re.compile("syslog", flags=re.IGNORECASE)
r = re.compile("shutting down", flags=re.IGNORECASE)
s = re.compile("Initializing", flags=re.IGNORECASE)
t = re.compile("Configuration", flags=re.IGNORECASE)
u = re.compile("starting up", flags=re.IGNORECASE) 
lines = open('log.csv')
array = []
temporary = 0
temp_q = 0
temp_r = 0
temp_s = 0
temp_t = 0
temp_u = 0

array_temp = []




for line in lines:
   
   line_temp = line.split(',')
   
   line_temp[0]= line_temp[0]+' '+line_temp[1]
   del line_temp[1]
   length = len(line_temp)
   line_temp[4:length] = [' '.join(line_temp[4:length])]
   
   if q.search(line_temp[4]) != None:
       temp_q = temp_q + 1
       
   if r.search(line_temp[4]) != None:
       temp_r = temp_r + 1       

   if s.search(line_temp[4]) != None:
       temp_s = temp_s + 1   

   if t.search(line_temp[4]) != None:
       temp_t = temp_t + 1

   if u.search(line_temp[4]) != None:
       temp_u = temp_u + 1       
   
    

   
   random_value = randint(0, 30000)
   line_temp.append(random_value)
   
   
   # new try
   
   # Getting the date correlation
   
   array.append(line_temp)
   
   
   # message = [' '.join(line_temp[4:length])]
   # line_temp.append(message)
   
   
   if p.search(line_temp[4]) != None:
       temporary = temporary + 1
       array_temp.append(line_temp[0])
         
   
   # if error in line_temp[4]:
   #    temporary = temporary + 1
   

   
   """
   if any("shutting down" in s for s in line_temp[4]):
       temporary = temporary + 1 
   """
    
   # del(line_temp[6:length])
   
   
   # line_temp[5] = line_temp[4]
   # del(line_temp[4])error = input("What Error stats you want to look at ? ")

   
   

   
   with open("logfinal1.csv", "a") as fp:
     wr = csv.writer(fp, dialect='excel')
     wr.writerow(line_temp)




# Visualization

  
objects = ('syslog', 'shutting down', 'Initializing', 'Configuration', 'starting up')
y_pos = np.arange(len(objects))
values = [temp_q, temp_r, temp_s, temp_t, temp_u]


plt.bar(y_pos, values)
plt.xticks(y_pos, objects, fontsize = 5, rotation = 30)
plt.ylabel('Number of times occurred')
plt.title('Analytical Comparison plot')

plt.savefig('fig1')

plt.show()

# Manipulation of the data



counter = collections.Counter(array_temp)

counter_append = collections.OrderedDict(counter)

ks = list(counter_append)

length_list = len(ks)

counter_values = counter_append.values()

counter_append_values = list(counter_values)




df = pd.read_csv('logfinal1.csv')
df.columns = ['Date','TIme','Service','Group','Message', 'Altitude']
df.to_csv('logfinal1.csv', index = False)


values_1 = []

for i in range(0,length_list):
    print(counter_append_values[i], "times", error, "has occured on", ks[i], "\n")
    values_1.append(counter_append_values[i])




    
objects_1 = (ks)
y_pos_1 = np.arange(len(objects_1))



plt.bar(y_pos_1, values_1, color="green")


plt.xticks(y_pos_1, objects_1, fontsize = 5, rotation = 30)
plt.ylabel('Number of times occurred')
plt.title('Indepth Data Analysis')

plt.savefig('fig2')
        
plt.show()

"""
i = 0

if(i<5):
    past[i].append(temporary)
    i = i+1
else:
    i=0
    past[i].append(temporary)
"""

"""    
x=5
width = 1/1.5
plt.bar(x,past,width, color="blue") 
fig = plt.gcf()
"""


os.remove('log.csv')  
   
   

# Here is the model for analysis

with open('logfinal1.csv') as inf:
    with open('outputfinal.csv', 'w') as outf:
        for line in inf:
            outf.write(','.join(line.split(' ')))

datafile = 'outputfinal.csv'

custom = pd.DataFrame.from_csv(datafile)

custom.rename(columns={
        'Date': 'Date',
        'Time': '  ',
        'Service': 'Time',
        'Group': 'Service',
        'Message': 'Group',
        'Altitude': 'Message',
        ' ': 'Altitude',})

custom.index = custom.index.rename(('Month',))
    
X = custom['Altitude']

Y = custom['Message']

    
from sklearn.preprocessing import LabelEncoder, OneHotEncoder

labelencoder_X_1 = LabelEncoder()

X.index = labelencoder_X_1.fit_transform(X.index)

# dint do one hot encoding

onehotencoder = OneHotEncoder(categorical_features = [1])

X = onehotencoder.fit_transform(X).toarray()
X = X[:, 1:]


# Splitting the dataset into the Training set and Test set

from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size = 0.2) 

# Feature Scaling
  
from sklearn.preprocessing import StandardScaler

sc = StandardScaler()

X_train = sc.fit_transform(X_train)

X_test = sc.transform(X_test)  


"""
   index = [i[0] for i in line_temp]
   not_index_list = [i[1:] for i in line_temp]
   pd = pandas.DataFrame(not_index_list, index=index)
   pd.to_csv("mylist.csv")
   """
   
"""
   with open("new_try.csv",'w') as f:
       for sublist in line_temp:
           for item in sublist:
               f.write(item + ',')
           f.write('\t')    
   """
"""
   my_df = pd.DataFrame(line_temp)
   my_df.to_csv('my_csv.csv')
   """
   
"""
   with open("log1.csv", "w") as f:
       writer = csv.writer(f, delimiter=',')
       writer.writerows(line_temp)
   """
   
   
  
    
    
    
    
    

    