#!/bin/bash

function say {
  echo $1
  ./dorji freq 144.5
  ./dorji tx
  echo $1 | festival --tts
  ./dorji rx
}

CALLSIGN="4x6ub"

echo "boot up"
echo callsign $CALLSIGN
./dorji init
say "$(./phonetify $CALLSIGN)"
say "starting up balloon mission 4"

COUNT=0
echo "lets go"
while :
do 
  ((COUNT++))
  if [ $COUNT -eq 5 ]
  then
    echo "sending image"
    ./go.sh
    let COUNT=0
  fi
   echo "sending aprs"
  ./piaprs $CALLSIGN -f /home/pi/build/gps.json
  sleep 60
done
