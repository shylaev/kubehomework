#!/bin/bash
count=0
counter=1
echo
echo -n "number of request to deploy?"
echo
read number
if [ -z $number ]
then number=100
fi

while [ $counter -le $number ]
do
curl -s http://192.168.59.100/ | grep -q 'canary' 
if [ $? -eq 0 ]
then ((count++))
fi
((counter++))
done
let "stable=$number - $count"
let "percent=100 * $count / $number | bc -l"

echo 'all requests was '$number', including to stable ' $stable 'and to latest version '$count 'or' $percent 'percent'
