#!/bin/bash

## filename     composer-known-dep-update.sh
## description: update a list of known composer-dependencies
## author:      jonas@sfxonline.de
## =========================================================

for row in $(jq -r '.[] | @base64' data/shops.json); do
    _jq() {
     echo "${row}" | base64 --decode | jq -r "${1}"
    }
  echo
  echo '-----------------'
  _jq '.name'
  echo '-----------------'

  updatedeps="$(_jq '.updatedeps')"
  if [ "$updatedeps" == "false" ]
  then
    echo "Update dependencies is set to $updatedeps so we skip this one."
    continue
  fi

  dryrun=$(ssh "$(_jq '.host')" "cd  $(_jq '.webroot') && $(_jq '.composer') update --dry-run" 2>&1)
  echo "$dryrun"

  for dep in $(jq -r '.[] | @base64' data/known-deps.json); do
    mydep=$(echo "${dep}" | base64 --decode)
    if echo "$dryrun" | grep -q "Upgrading $mydep"
    then
        echo
        echo ">>>>> FOUND $mydep to update"
        ssh "$(_jq '.host')" "cd  $(_jq '.webroot') && $(_jq '.composer') update $mydep"
    fi
  done
done
