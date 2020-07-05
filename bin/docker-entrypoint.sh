#!/bin/bash
set -x

USER=horizen
DIR=$HOME/.zen

chown -R ${USER} /opt/nodetracker
exec gosu ${USER} "$@"