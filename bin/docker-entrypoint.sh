#!/bin/bash
set -x

USER=horizen
DIR=/opt/nodetracker/config
CONFIG=${DIR}/config.json
SEED_SERVERS='"ts1.eu",
   "ts1.na",
   "ts6.eu",
   "ts5.eu",
   "ts2.na",
   "ts3.na",
   "ts4.eu",
   "ts2.eu",
   "ts3.eu",
   "ts4.na"'
# create directory and config file if it does not exist yet
if [ ! -e "${CONFIG}" ]; then
    mkdir -p ${DIR}
    echo "Creating ${CONFIG}"
    cat <<EOF > ${CONFIG}
{
 "active": "${NODE_TYPE:-secure}",
 "${NODE_TYPE:-secure}": {
  "nodetype": "${NODE_TYPE:-secure}",
  "nodeid": ${NODE_ID:-SETMYIDUP},
  "servers": [${SERVERS:-$SEED_SERVERS}],
  "stakeaddr": "${STAKEADDR}",
  "email": "${EMAIL}",
  "fqdn": "${FQDN}",
  "ipv": "${IPV:-4}",
  "region": "${REGION:-na}",
  "home": "${PHONEHOME:-ts1.na}",
  "category": "${CATEGORY:-none}"
 }
}
EOF
fi
cat ${CONFIG}
chown -R ${USER} $HOME /opt/nodetracker /usr/local
exec "$@"