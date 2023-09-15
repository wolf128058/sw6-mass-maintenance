# sw6-mass-maintenance
Just a few scripts to maintain/update multiple shopware setups.

You will need composer and the shopware-console.

## Configuration:
* See [shops.example.json](data/shops.example.json) for configuration example and make your own *shops.json* out of this file in the same place.
* See [known-deps.json](data/known-deps.json) for known dependencies. This is a "whitelist" for [composer-known-dep-update.sh](composer-known-dep-update.sh) and sets those ones that get updated automatically.
* Directory data/pluginstatus is containing the jsons (private submodule for reasons)
