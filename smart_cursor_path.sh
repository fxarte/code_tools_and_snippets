# !/bin/bash

function smart_path() {
  IFS=/
  PATH=`pwd`

  ARR=($PATH)
  TOTAL=${#ARR[@]}
  if [ "$TOTAL" -gt "10" ]; then
    let "MED = $TOTAL/2"
    echo "${ARR[1]}/../${ARR[$MED]}/../${ARR[$TOTAL-1]}"
  else
    pwd
  fi
}