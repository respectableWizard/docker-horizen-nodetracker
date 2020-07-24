#!/bin/bash
set -x

DIR=$HOME/.zen
FILENAME=zen.conf
FILE=$DIR/$FILENAME
cat $FILE
echo "Initialization completed successfully"
EXECUTABLE="node apps.js"
exec $EXECUTABLE