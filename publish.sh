#! /usr/bin/sh
if [ -z "$1" ]
    then
        echo "No draft file found"
        exit
fi
 
Full_Date=`date +"%Y-%m-%d %T"`
sed -i "s/date:.*/date: $Full_Date/" $1
mv $1 _posts/`date +"%Y-%m-%d"`-`basename $1`

echo "Published $1 at $Full_Date"