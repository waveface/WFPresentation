#!/bin/bash --

FROM_DIR=`pwd`
TEMP_DIR=`mktemp -d '/tmp/Synergised.XXXXXX'`	# Clean me up
COMMIT_SHA="`git rev-parse HEAD`"

cp -r . $TEMP_DIR
cd $TEMP_DIR

sass WFPreview.scss WFPreview.css

rm -vrf ".git"

zip -qr Synergised.zip . -x "\*.git"
mv Synergised.zip "$FROM_DIR/Synergised-$COMMIT_SHA.zip"

rm -rv $TEMP_DIR
