#!/bin/bash

## filename     composer-audit.sh
## description: run "composer audit" on each shop
##              check for reported security vulnerabilities
##              in the list of packages versions currently installed.
## author:      jonas@sfxonline.de
## =======================================================================

for row in $(jq -r '.[] | @base64' data/shops.json); do
    _jq() {
     echo "${row}" | base64 --decode | jq -r "${1}"
    }
  echo
  echo '-----------------'
  _jq '.name'
  echo '-----------------'
  ssh "$(_jq '.host')" "cd  $(_jq '.webroot') && $(_jq '.composer') audit"
done
