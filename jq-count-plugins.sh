#!/bin/bash

## filename     jq-count-plugins.sh
## description: after collecting plugin information in data/pluginstatus/*.json
##              (done by ./console-plugin-list.sh)
##              this one just county the entries as amount of plugins
##              installed on your different instances
## author:      jonas@sfxonline.de
## =======================================================================

for file in data/pluginstatus/*.json; do
   jq -r --arg filename "$file" '(length | tostring) + " --> " + $filename' "$file";
done
