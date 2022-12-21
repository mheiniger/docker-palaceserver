#!/usr/bin/env bash

set -e

# initial setup
if [ -z "$(ls -A /app/run/media)" ]; then
    cp -r -v /app/palace/media/. /app/run/media/
    chown -R palace:palace /app/run/media
fi

if [ -z "$(ls -A /app/run/psdata)" ]; then
    cp -r -v /app/palace/psdata/. /app/run/psdata/
    chown -R palace:palace /app/run/psdata
fi

if [ -z "$(ls -A /app/run/logs)" ]; then
    mkdir -p /app/run/logs/
    touch pserver.log
    chown -R palace:palace /app/run/logs
fi

if [ -z "$(ls -A /app/run/avatars)" ]; then
    cp -r -v /app/palace/avatars/. /app/run/avatars/
    chown -R palace:palace /app/run/avatars
fi

if [ -z "$(ls -A /app/run/webservice/props)" ]; then
    cp -r -v /app/palace/webservice/. /app/run/webservice/
    chown -R palace:palace /app/run/webservice
fi

chown -R palace:palace /app/run

# if [ ! -d "/app/run/logs" ]; then 
#     cp -r /app/palace/logs/. /app/run/logs/
# fi

su palace

sudo --user=palace /app/bin/pserver -f /app/run/psdata/pserver.conf -s /app/run/psdata/plugin.conf &
 echo $! > /app/run/logs/pserver.pid

tail -f /app/run/logs/pserver.log
