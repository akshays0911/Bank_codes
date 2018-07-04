#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul  2 16:58:34 2018

@author: akshay1109
"""

import sys 
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QToolTip, QDesktopWidget
from PyQt5.QtGui import QFont

"""
if __name__ == '__main__':
    
    # application object
    app = QApplication(sys.argv)
    
    # Default constructor
    w = QWidget()
    
    w.resize(250, 150)
    w.move(300, 300)
    w.setWindowTitle('Simple')
    w.show()
"""   
    
# Application icon
 
from PyQt5.QtGui import QIcon


class Example(QWidget):
    
    def __init__(self):
        super().__init__()
        
        self.initUI()
        
      
    def initUI(self):
     
     QToolTip.setFont(QFont('SansSerif', 10))
      
     self.setToolTip('This is a <b>QWidget</b> widget')
     
     bin = QPushButton('Button', self)
     bin.setToolTip('This is a <b>aQPushButton</b> Widget')
     bin.resize(bin.sizeHint())
     bin.move(50, 50)
     
     qbtn = QPushButton('Quit', self)
     qbtn.clicked.connect(QApplication.instance().quit)
     qbtn.resize(qbtn.sizeHint())
     qbtn.move(50, 100)       
     
     self.setGeometry(300, 300, 300, 220)
     self.setWindowTitle('Icon')
     self.setWindowIcon(QIcon('web.png'))
     
     self.show()

"""
    def closeEvent(self, event):

    # Message box 
       
      reply = QMessageBox.question(self, 'Message',
            "Are you sure to quit?", QMessageBox.Yes | 
            QMessageBox.No, QMessageBox.No)

      if reply == QMessageBox.Yes:
            event.accept()
      else:
            event.ignore()        
"""
def center(self):
        
        qr = self.frameGeometry()
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())
        
         
        
     
if __name__ == '__main__':
    
    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())