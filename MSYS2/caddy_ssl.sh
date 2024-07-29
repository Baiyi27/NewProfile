#!/bin/bash

cp steamcommunityCA.pem /etc/pki/ca-trust/source/anchors/steamcommunityCA.crt
update-ca-trust
./steamcommunity_302.caddy run --config steamcommunity_302.caddy.json --adapter caddyfile &