#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 13 11:43:13 2018

@author: akshay1109
"""

#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys 
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QToolTip, QDesktopWidget, QLineEdit, QMessageBox, QMainWindow, QLabel
from PyQt5.QtCore import pyqtSlot, QSize
from PyQt5.QtGui import QFont



# Create an PyQT4 application object.
a = QApplication(sys.argv)
 
# The QWidget widget is the base class of all user interface objects in PyQt4.
w = QWidget()
 
# Set window size.
w.resize(600, 300)
 
# Set window title
w.setWindowTitle("OLAA")

# Creating a text Box
textbox = QLineEdit(w)
textbox.move(100, 100)
textbox.resize(280,40)




# Creating a button

# Create a button in the window
button = QPushButton('Search', w) 
button.move(400,107)

# Create the actions

@pyqtSlot()
def on_click():
    textbox.setText("Button clicked.")

# connect the signals to the slots
button.clicked.connect(on_click)

# Show window
w.show()

"""
@pyqtSlot()
def on_click(self):    
   textboxValue = self.textbox.text()
   QMessageBox.question(self, 'Message - pythonspot.com', "Fetching" + textboxValue + "Data...", QMessageBox.Ok, QMessageBox.Ok)
   self.textbox.setText("")
"""    

 
sys.exit(a.exec_())