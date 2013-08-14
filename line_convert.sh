#!/bin/bash
CURRENT_FOLDER="`pwd`"
COMMANDS="d2u dos2unix;u2d unix2dos"
I="u2d"
COMMAND=(`echo $COMMANDS | tr ";" "\n" | grep $I`)
COMMAND=${COMMAND[1]}
echo $COMMAND
if [ -d $1 ]; then
  OPERATION="$COMMAND -k"
  #d2u
  #u2d
  
  for FILE in $1/*; do
    if [ -f "$FILE" ]; then
      $OPERATION $CURRENT_FOLDER/$FILE
    fi
  done


fi
