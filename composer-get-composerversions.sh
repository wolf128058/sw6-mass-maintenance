#!/bin/bash

## filename     composer-get-composerversions.sh
## description: get composers own version on each instance
## author:      jonas@sfxonline.de
## =======================================================

for row in $(jq -r '.[] | @base64' data/shops.json); do
    _jq() {
     echo "${row}" | base64 --decode | jq -r "${1}"
    }
  echo
  echo '-----------------'
  _jq '.name'
  echo '-----------------'
  ssh "$(_jq '.host')" "$(_jq '.composer') -V"
done
