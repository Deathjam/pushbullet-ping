#!/bin/bash

# Sign up at: https://www.pushbullet.com/
# Enter your api and device_id below

SERVER=www.google.com #SERVER TO PING
URL=https://www.pushbullet.com/api/pushes #PUSHBULLET API URL
API= #ACCOUNT API KEY
DEV= #DEVICE ID
HEADING="Houston we have a problem" #NOTE TITLE
MESSAGE="Everything is on fire and the world is ending, oh noes" #NOTE BODY

while true
do
if ping -c 1 $SERVER > /dev/null;
    then echo "Everything is OK at $(date)"
  else
        curl -s $URL -u $API: -d device_id=$DEV -d type=note -d title=$HEADING -d body="$MESSAGE $(date)" -X POST
    exit 0
  fi
sleep 300
done
