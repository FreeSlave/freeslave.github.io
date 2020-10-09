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

for repo in inilike desktopfile icontheme mimeapps xdgpaths mime
do
    if [ ! -d $REPOS/$repo ]; then
        (cd $REPOS && git clone https://github.com/FreeSlave/$repo --branch master --single-branch)
    fi

    (cd $REPOS/$repo && git pull --ff --rebase=false origin master)
    find $REPOS/$repo/source -maxdepth 1 -mindepth 1 -exec ln -sfr "{}" ${COMMONDIR}/source \;
done

(cd $COMMONDIR && dub build -b ddox)
