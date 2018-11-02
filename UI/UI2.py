#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 13 15:18:40 2018

@author: akshay1109
"""

import sys
from PyQt5 import QtCore, QtWidgets
from PyQt5.QtWidgets import QMainWindow, QWidget, QLabel, QLineEdit, QPushButton
from PyQt5.QtCore import QSize   

class MainWindow(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)

        self.setMinimumSize(QSize(600, 300))    
        self.setWindowTitle("OLAA BOEING") 

        self.nameLabel = QLabel(self)
        self.nameLabel.setText('Airplane ID :')
        self.line = QLineEdit(self)

        self.line.move(100, 100)
        self.line.resize(280, 40)
        self.nameLabel.move(100, 70)

        pybutton = QPushButton('Search', self)
        pybutton.clicked.connect(self.clickMethod)
        pybutton.resize(100,32)
        pybutton.move(400, 107) 
       #  pybutton.clicked.connect(showdialog)
        
        pybutton1 = QPushButton('ERROR DATA', self)
        pybutton1.clicked.connect(self.clickMethod)
        pybutton1.resize(200,50)
        pybutton1.move(100, 170) 
        
"""
    def showdialog():
        msg = QMessageBox()
        msg.setIcon(QMessageBox.Information)

        msg.setText("This is a message box")
        msg.setInformativeText("This is additional information")
        msg.setWindowTitle("MessageBox demo")
        msg.setDetailedText("The details are as follows:")
        msg.setStandardButtons(QMessageBox.Ok | QMessageBox.Cancel)
"""

def clickMethod(self):
        print('Your name: ' + self.line.text())

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    mainWin = MainWindow()
    mainWin.show()
    sys.exit( app.exec_() )