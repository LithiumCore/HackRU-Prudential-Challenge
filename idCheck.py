#!/usr/bin/python

import csv
import sys

#input number you want to search
number = input('Enter ID to find\n')

#read csv, and split on "," the line
csv_file = csv.reader(open('fullSolution.csv', "r"), delimiter=",")

#loop through csv list
for row in csv_file:
#if current rows 2nd value is equal to input, print that row
    if number == row[1]:
        print("found ID!")
        if row[2] == '0':
            print("Not Lowest Risk")
        elif row[2] == '1':
            print("Lowest Risk")
		