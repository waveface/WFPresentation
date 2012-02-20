#!/bin/bash --

FROM_DIR=`pwd`
TEMP_DIR=`mktemp -d '/tmp/Synergised.XXXXXX'`	# Clean me up
COMMIT_SHA="`git rev-parse HEAD`"
DATE="`date +\"%Y-%m-%d %T %z\"`"

echo $COMMIT_SHA
echo $DATE

cp -r Source $TEMP_DIR/Synergised
cd $TEMP_DIR//Synergised

rm -vrf .git
rm -vrf .sass-cache
rm -vrf config.rb
rm -vrf *.scss
rm -vrf *Debug.js

zip -qr Synergised.zip . -x "\*.git"
mv Synergised.zip "$FROM_DIR/Product/Synergised ${COMMIT_SHA:0:7}.zip"

rm -rv $TEMP_DIR
