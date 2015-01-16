#!/bin/bash

# Author: Phil Wray
# Sign up at: https://www.pushbullet.com/
# Enter your api and device_id below
# Add script to cron to make sure always running

SERVER=www.google.com #SERVER TO PING
URL="https://api.pushbullet.com/v2/pushes" #PUSHBULLET API URL
API= #ACCOUNT API KEY

NOTETITLE="Houston we have a problem" #NOTE TITLE
NOTEBODY="Everything is on fire and the world is ending, oh noes" #NOTE BODY
SLEEP=120 #Sleep time in seconds
LOCKFILE=/tmp/pb-ping.lock

#Create lock file
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
        echo "already running"
        exit
fi

trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

# Actual script
while true
do
if ping -c 1 $SERVER > /dev/null;
    then echo "Everything is fine at $(date)"
  else
          curl -u $API: -X POST $URL --header 'Content-Type: application/json' --data-binary '{
                "type": "note",
                "title":"'"$NOTETITLE"'",
                "body": "'"$NOTEBODY"'"
        }'
        
    exit 0
  fi
sleep $SLEEP
done

#Remove lockfile
rm -f ${LOCKFILE}
