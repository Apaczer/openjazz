#!/bin/sh

OPK_NAME=openjazz.opk

echo ${OPK_NAME}

# create default.retrofw.desktop
cat > default.retrofw.desktop <<EOF
[Desktop Entry]
Name=OpenJazz
Comment=Jazz Jackrabbit™ game engine reimplementation
Exec=openjazz.dge
Terminal=false
Type=Application
StartupNotify=true
Icon=openjazz
Categories=games;
EOF

# duplicate desktop file for opendingux
cp default.retrofw.desktop default.gcw0.desktop

# create opk
FLIST="openjazz"
FLIST="${FLIST} default.retrofw.desktop"
FLIST="${FLIST} default.gcw0.desktop"
FLIST="${FLIST} dist/*"

rm -f ${OPK_NAME}
mksquashfs ${FLIST} ${OPK_NAME} -all-root -no-xattrs -noappend -no-exports

cat default.retrofw.desktop
rm -f default.retrofw.desktop
rm -f default.gcw0.desktop