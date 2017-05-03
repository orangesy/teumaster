#!/bin/bash

function shut_down() {
    echo shutting down
    /etc/init.d/postgresql stop
    /etc/init.d/supervisord stop
    exit
}
trap "shut_down" SIGKILL SIGTERM SIGHUP SIGINT EXIT

/etc/init.d/postgresql start
supervisord -n
