#!/bin/bash
svn log --stop-on-copy | grep -EA2 r[0-9]+ | sed 's/^--//' | sed '/^$/d' | sed '$!N;s/\n/ | /'
