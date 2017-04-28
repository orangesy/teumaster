#!/bin/bash

/etc/init.d/postgresql start
supervisord -n
