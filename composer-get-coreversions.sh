#!/bin/bash

## filename     composer-get-coreversions.sh
## description: run "shopware core-version from composer.lock" on each shop
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
  ssh "$(_jq '.host')" "cd  $(_jq '.webroot') && cat composer.lock" | jq -r '.packages[] | select(.name=="shopware/core") .version'
done