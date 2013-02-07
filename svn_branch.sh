#!/bin/bashi
#include in the colling code the error capturing code
function svnbranch(){
 URL=(`svn info 2>/dev/null | grep URL`)
 if [ "$?" -ne 0 ]; then
  #not an svn repo, exit graciously
  exit 0
 fi
 URL=${URL[1]}
 SVN_ROOT=(`svn info | grep "Repository Root"`)
 SVN_ROOT=${SVN_ROOT[2]}
 SVN_FOLDER=${URL/$SVN_ROOT//}
 SVN_FOLDER=${SVN_FOLDER/portal_two/}
 SVN_FOLDER=${SVN_FOLDER/branches/B:}
 SVN_FOLDER=${SVN_FOLDER/tags/T:}
 SVN_FOLDER=${SVN_FOLDER//\//}
 echo "($SVN_FOLDER)";
}

