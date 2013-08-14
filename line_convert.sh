#!/bin/bash
function usage() {
  echo -e "Invalid arguments.\n$0 <folder> [u2d | d2u]"
}
CURRENT_FOLDER="`pwd`"
COMMANDS="d2u dos2unix;u2d unix2dos"
I="u2d"
if [ -n "$2" ]; then
  I=$2
fi
COMMAND=(`echo $COMMANDS | tr ";" "\n" | grep $I 2>/dev/null`)
COMMAND=${COMMAND[1]}

if [ -z "$COMMAND" ]; then
  usage
  exit 1
fi
echo "$COMMAND"
if [ -d $1 ]; then
  OPERATION="$COMMAND -k"
  
  for FILE in $1/*; do
    #echo -n "$FILE ..."
    if [ -f "$FILE" ]; then
      $OPERATION $FILE
    fi
  done
echo

fi
