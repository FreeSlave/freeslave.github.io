#!/bin/sh

set -e

COMMONDIR=d-freedesktop

if [ ! -d $COMMONDIR/source ]; then
    mkdir -p $COMMONDIR/source
fi

if [ ! -d repos ]; then
    mkdir -p repos
fi

REPOS=repos

for repo in inilike desktopfile icontheme mimeapps xdgpaths
do
    if [ ! -d $REPOS/$repo ]; then
        (cd $REPOS && git clone https://github.com/MyLittleRobo/$repo)
    fi
    
    (cd $REPOS/$repo && git pull --ff --rebase=false origin master)
    cp -r $REPOS/$repo/source $COMMONDIR/
done

(cd $COMMONDIR && dub build -b ddox)
