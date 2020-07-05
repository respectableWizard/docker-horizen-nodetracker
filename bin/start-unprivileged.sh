#!/bin/bash
set -x

DIR=$HOME/.zen
FILENAME=zen.conf
FILE=$DIR/$FILENAME

# create directory and config file if it does not exist yet
if [ ! -e "$FILE" ]; then
    mkdir -p $DIR
    echo "Creating $FILENAME"
    # Seed a random password for JSON RPC server
    cat <<EOF > $FILE
printtoconsole=${PRINTTOCONSOLE:-1}
externalip=${EXTERNALIP}
rpcbind=$(hostname -I | awk '{print $1}')
rpcallowip=${RPCALLOWIP:-172.17.0.0/16}
server=1
masternode=1
daemon=0
listen=0
txindex=1
logtimestamps=1
rpcuser=${RPCUSER:-horizenrpc}
rpcpassword="${RPCPASSWORD:-`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`}"
rpcport=${RPCPORT:-18231}
rpcworkqueue=512
tlscertpath=${DIR}/letsencrypt/live/${FQDN}/cert.pem
tlskeypath=${DIR}/letsencrypt/live/${FQDN}/privkey.pem
port=${PORT:-9033}
EOF

fi
cat $FILE
ls -lah $DIR/

echo "Initialization completed successfully"
EXECUTABLE="node apps.js"
exec $EXECUTABLE