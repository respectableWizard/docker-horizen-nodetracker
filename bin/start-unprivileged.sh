#!/bin/bash
set -x

echo "Initialization completed successfully"
n 10.12.0 &&
EXECUTABLE="node app.js" &&
exec $EXECUTABLE