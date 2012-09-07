#!/bin/bash
# echo $1
# exit 0
# cd <profile/version controlled directory>
echo "doing git pull.."
SNIPPETS_PATH="../code_tools_and_snippets"
git pull
# cd <site root folder>
if [ -n "$1" ]; then
  echo "reloading DB.."
  # remove the tables from the drupal DB
  cat $SNIPPETS_PATH/sql/drop-all-tables.sql | drush sql-cli
  # load the provided DB
  if [ -f "$2" ]; then
    cat $2 | drush sql-cli
  fi
fi
echo "Making cahce tables MyISAM.."
$(drush sql-connect) < $SNIPPETS_PATH/sql/make-cache_tables-mysam.sql
# include customization commands here
drush dl devel -n
drush en devel -y
drush vset file_temporary_path "/tmp"
drush vset preprocess_js 0
drush vset preprocess_css 0
drush vset page_compression 0
drush vset cache 0
drush vset cache_lifetime 0
drush uublk admin
drush upwd admin --password="admin"
