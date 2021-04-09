#!/bin/bash

path="/var/log/"                 # set file path         
timestamp=$(date +%Y%m%d_%H%M%S)    
filename=log_$timestamp.gz           # set your log file extension 
log=$path$filename
days=                                # set no of days you want to delete the file

START_TIME=$(date +%s)

find $path -maxdepth 1 -name "*.gz" -type f -mtime +$days  -print -delete >> $log

