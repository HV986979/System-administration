#! /bin/bash
#Installed  ssmtp & mailutils

duplicatelogcount=`wc -l /var/webserver_monitor/monitorlog.log | awk '{print $1}'`
unauthlogcount=`wc -l /var/webserver_monitor/unauthorized.log | awk '{print $1}'`
echo $duplicatelogcount
echo $unauthlogcount
if [ "$duplicatelogcount" != "$unauthlogcount" ]
then
     
        diff /var/webserver_monitor/unauthorized.log /var/webserver_monitor/monitorlog.log > new_invalid_access
        sudo sed -i "1d" new_invalid_access 
        sudo sed -i s/\<//g  new_invalid_access 
        mail -s "unauthorized.log updates" -A new_invalid_access harshawcu@gmail.com < new_invalid_access 
        cp /var/webserver_monitor/unauthorized.log /var/webserver_monitor/monitorlog.log
else
        echo "No unauthaccess" | mail -s "No unauthorized access." harshawcu@gmail.com
fi
