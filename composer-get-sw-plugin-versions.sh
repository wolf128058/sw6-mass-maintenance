#!/bin/bash

## filename     composer-get-sw-plugin-versions.sh
## description: get plugins from store.shopware.com on each shop
##              out of composer.lock
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
  ssh "$(_jq '.host')" "cd  $(_jq '.webroot') && cat composer.lock" | jq -r '.packages[] | {name, version} | select(.name | startswith("store.shopware.com/"))'
done
