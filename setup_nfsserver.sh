#!/bin/bash

set -x

sudo apt update
sudo apt install -y nfs-common
mkdir /var/webserver_monitor
sudo chown nobody:nogroup /var/webserver_monitor
sudo mount 192.168.1.1:/var/webserver_log /var/webserver_monitor
cd /var/webserver_log
