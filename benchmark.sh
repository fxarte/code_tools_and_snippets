#!/bin/bash
./../update_db.sh logged-in-MEM.sql && cd html/ && drush wd-del all -y && drush cc all
drush php-eval '_post_deployment_tasks();'
START=`date +"%N"`
drush php-eval 'node_access_rebuild();'
END=`date +"%N"`
DURATION=$(($END-$START))
echo $DURATION


