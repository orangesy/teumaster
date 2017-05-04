#!/bin/bash

function shut_down() {
    echo shutting down
    /etc/init.d/ssh stop
    exit
}

trap "shut_down" SIGKILL SIGTERM SIGHUP SIGINT EXIT

if [ -n "${KEYS}" ]; then
  echo "${KEYS}" >> /home/ubuntu/.ssh/authorized_keys
fi

echo "search example.com" >> /etc/resolv.conf
echo "domain example.com" >> /etc/resolv.conf

/usr/sbin/sshd -D
