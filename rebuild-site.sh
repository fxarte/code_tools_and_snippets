#!/bin/bash
# run from already installed HTML folder
# use -i to install the provided profile using drush
# provided profile defaults to default
# 
function usage(){
  echo "$0 -duh [profilename=default]" 
}
if [ -z "$1" ]; then
  usage
  exit 0
fi
if [ "$1" = "-h" ]; then
  usage
  exit 0
fi

# remove the tables before removing the drupal DB settings
cat ../code_tools_and_snippets/sql/drop-all-tables.sql | drush sql-cli

# Make the site ready for reinstall by replacing seetings file with the default
sudo cp sites/default/default.settings.php ../settings.php
sudo rm -rf ../files/*.*
sudo chmod 664 ../settings.php

#reinstall the site using drush if commanded
if [ "$1" == "-d" ]; then
  DEFAULT_PROFILE="default"
  if [ -n "$2" ]; then
    DEFAULT_PROFILE=$2
  fi
  echo installing $DEFAULT_PROFILE
  drush si $DEFAULT_PROFILE --account-name=admin --account-pass=admin --account-mail=em@il.me --site-name=$2 --db-url=mysql://drupal_db:drupal_db_pwd@localhost/drupal_db
  drush dl coder -y
  drush en coder, coder_review -y
fi
