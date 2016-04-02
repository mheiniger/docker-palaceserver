#!/usr/bin/env bash

app/bin/start-palace

tail -f app/palace/logs/pserver.log
