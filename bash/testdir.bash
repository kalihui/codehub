#!/bin/bash


predir=$(readlink -f "$0")
predir=$(dirname "$predir")

workdir=/home/ukaihui
cd $workdir/codehub
mkdir testresult
touch test1.txt
echo 'Thanks! Test complete'
cd $predir
