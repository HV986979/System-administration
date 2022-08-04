#! /bin/bash
sudo apt install geoip-bin > /dev/null
sudo grep -ie "invalid user" -ie "unauthorized" -ie "Failed password"   /var/log/auth.log | awk '{print $1" " $2 " " $3 " " $11}' > modify_unau.log
while IFS= read -r line; do
        ip=`echo $line | awk '{print $4}'`
        if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]; then
           date=`echo $line | awk '{print $1" " $2 " " $3}'`
        echo $ip,$(geoiplookup -s $ip | cut -d ":" -f2),$date >> /var/webserver_log/unauthorized.log
        fi
done < "modify_unau.log"
