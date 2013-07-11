#!/bin/bash
DOC_ROOT="`pwd`"
OPERATION=""
#include box system settings with HOST, USER and PASSWORD definitions
. ~/.env/environment.properties
function usage() {
  cat <<EOF
Synopsis
    $0 <-l | -r | -p> <-d database> <-f file>
    -a: archive DB; comming up
    -l: loads DB
    -r: reloads DB
    -p: drops DB
EOF
}

function clear_db() {
  $MYSQL -BNe "SHOW tables" $DATABASE | awk '{print "DROP TABLE IF EXISTS `" $1 "`;"}' | $MYSQL
}
function load_db() {
  echo "File name $SCRIPT_FILE"
  $MYSQL "$DATABASE" < $SCRIPT_FILE
}

function archive() {
  echo "archiving"
}


# Options.
while getopts "alrpd:f:" option; do
  case "$option" in
    a)
       OPERATION="ARCHIVE"
    ;;
    l)
       OPERATION="LOAD"
    ;;
    r)
       OPERATION="RELOAD"
    ;;
    p)
       OPERATION="DROP"
    ;;
    d)
       DATABASE=$OPTARG
    ;;
    f)
       SCRIPT_FILE=$OPTARG
    ;;
    *)
       echo "last option"
       usage
       exit 1
    ;;
  esac
done
#shift $((OPTIND - 1))

if (($# == 0 || ${#DATABASE} == 0)); then
	echo $#
	echo ${#DATABASE}
	echo "No options or DB specified"
    usage
    exit 1
fi

if [ "$OPERATION" == "LOAD" -o "$OPERATION" == "RELOAD" ]; then
  if [ -z "$SCRIPT_FILE" ]; then
    echo "Operation $OPERATION requires a SQL file."
    usage
    exit 1
  else
    if [ ! -f "$SCRIPT_FILE" ]; then
      echo "invalid file $SCRIPT_FILE, or file does not exists"
      usage
      exit 1
    fi
  fi
fi

MYSQL="mysql --database=$DATABASE --host=$HOST --user=$USER --password=$PASSWORD"
echo "Running operation: $OPERATION, with DataBase: $DATABASE and file: $SCRIPT_FILE"

case "$OPERATION" in
  LOAD)
    echo "File name $SCRIPT_FILE"
    load_db
  ;;
  RELOAD)
    clear_db
    load_db
  ;;
  DROP)
    clear_db
    echo "$DATABASE all tables dropped"
  ;;
  *)
   echo "nothing to do"
  ;;
esac

