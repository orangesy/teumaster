#!/bin/bash

/etc/init.d/beanstalkd start
bash -c "cd /root/src/worker; source /root/src/worker/virtualenv/bin/activate; bash worker_start magna 1"

sleep infinity
