#!/bin/bash
set -x

USER=horizen
DIR=$HOME/.zen

chown -R ${USER} $HOME /opt/nodetracker 
exec gosu ${USER} "$@"