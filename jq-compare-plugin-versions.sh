#!/bin/bash

## filename     jq-compare-plugin-versions.sh
## description: after collecting plugin information in data/pluginstatus/*.json
##              (done by ./console-plugin-list.sh)
##              you can get the versions of a certain plugin
##              installed on your different instances
## author:      jonas@sfxonline.de
## =======================================================================

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <plugin_name>"
    exit 1
fi

plugin_name="$1"

for file in data/pluginstatus/*.json; do
   jq -r --arg plugin_name "$plugin_name" --arg filename "$file" '.[] | select(.name==$plugin_name).version + " --> " + $filename' "$file";
done
