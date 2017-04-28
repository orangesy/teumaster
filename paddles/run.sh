#!/bin/bash

/etc/init.d/postgresql start

pecan serve config.py
