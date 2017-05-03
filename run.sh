#!/bin/bash

/etc/init.d/beanstalkd start
/etc/init.d/nginx start
bash -c "cd /root/src/worker; source /root/src/worker/virtualenv/bin/activate; worker_start.sh magna 1"

echo "172.17.0.3 magna001 magna001.example.com" >> /etc/hosts
echo "172.17.0.4 magna002 magna002.example.com" >> /etc/hosts
echo "172.17.0.5 magna003 magna003.example.com" >> /etc/hosts

sleep infinity
