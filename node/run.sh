#!/bin/bash

if [ -n "${KEYS}" ]; then
  echo "${KEYS}" >> /home/ubuntu/.ssh/authorized_keys
fi

/usr/sbin/sshd -D
