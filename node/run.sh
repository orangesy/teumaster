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

/usr/sbin/sshd -D
