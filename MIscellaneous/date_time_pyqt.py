#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul  2 16:44:10 2018

@author: akshay1109
"""

# Code using pyqt to display current date and time 

from PyQt5.QtCore import QDate, QTime, QDateTime, Qt

current_date = QDate.currentDate()

print(current_date.toString(Qt.ISODate))
# print(current_date.toString(Qt. DefaultLocaleLongDate))

datetime = QDateTime.currentDateTime()

print(datetime.toString())

time = QTime.currentTime()

print(time.toString(Qt.DefaultLocaleLongDate))