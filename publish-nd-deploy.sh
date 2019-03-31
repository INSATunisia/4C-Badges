#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Provide a message for the commit please"
    exit 1
fi
git add .
git commit -m $1
git push
now

