#!/bin/sh

mkdir -p ipkg/home/retrofw/games/openjazz
mkdir -p ipkg/home/retrofw/apps/gmenu2x/sections/games
cp OpenJazz ipkg/home/retrofw/games/openjazz/openjazz
cp openjazz.000 ipkg/home/retrofw/games/openjazz/
cp gpl.txt ipkg/home/retrofw/games/openjazz/
cp licenses.txt ipkg/home/retrofw/games/openjazz/
cp -R dist/*  ipkg/home/retrofw/games/openjazz/

cd ipkg

# create control
cat > temp <<EOF
Package: OpenJazz
Version: 
Description: Jazz Jackrabbit™ game engine reimplementation
Section: games
Priority: optional
Maintainer: scooterpsu
Architecture: mipsel
Homepage: https://github.com/scooterpsu/OpenJazz
Depends:
Source: https://github.com/scooterpsuOpenJazz
EOF
sed "s/^Version:.*/Version: $(date +%Y%m%d)/" temp > control

# create debian-binary
echo '2.0' > debian-binary

# create gmenu2x links
cat > home/retrofw/apps/gmenu2x/sections/games/openjazz.lnk <<EOF
title=OpenJazz
description=Jazz Jackrabbit™ game engine reimplementation
exec=/home/retrofw/games/openjazz/openjazz.dge
clock=600
EOF

#build ipk
tar -czvf control.tar.gz control --owner=0 --group=0
tar -czvf data.tar.gz home --owner=0 --group=0
ar rv ../openjazz.ipk control.tar.gz data.tar.gz debian-binary

cd ..
rm -r ipkg
