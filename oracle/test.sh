#!/bin/sh
row=`wc -l < temp.txt`
for ((i =1;i <= $row;i=i+1))
do
onerow=`sed -n "$i"p < temp.txt`
for (( j =1; j <=10;j=j+1))
do
echo $i $onerow>>$j+.txt
done
done
