#!/bin/bash

######### Only These two lines to edit with new version #####
version=2.6
#############################################################
PLUGINPATH='/usr/lib/enigma2/python/Plugins/Extensions/ArabicSavior'

# Download and install plugin
cd /tmp
set -e
rm -rf *ArabicSavior* > /dev/null 2>&1
echo "Backup keymap.xml"
echo ""
cp -f $PLUGINPATH/keymap.xml /tmp > /dev/null 2>&1 || true

# Download the specific tarball using the raw URL provided
wget --no-check-certificate -O main.tar.gz https://github.com/popking159/ArabicSavior/raw/refs/heads/main/main.tar.gz

if [ -f '/tmp/main.tar.gz' ]; then
   	opkg remove enigma2-plugin-extensions-arabicsavior > /dev/null 2>&1 || true
	rm -rf $PLUGINPATH > /dev/null 2>&1
fi

# Extract the downloaded tarball
tar -xf main.tar.gz

# Handle both possible extraction directory structures
if [ -d "main/usr" ]; then
    cp -rf main/usr /
elif [ -d "usr" ]; then
    cp -rf usr /
fi

# Cleanup temp files
rm -rf *ArabicSavior* > /dev/null 2>&1
rm -rf main.tar.gz main usr > /dev/null 2>&1

echo "Restore keymap.xml"
cp -f /tmp/keymap.xml $PLUGINPATH > /dev/null 2>&1 || true
echo ""
set +e
cd ..
sync

### Check if plugin installed correctly
if [ ! -d "$PLUGINPATH" ]; then
	echo "Something went wrong .. Plugin not installed"
	exit 1
fi

sync
echo "#########################################################"
echo "#      ArabicSavior INSTALLED SUCCESSFULLY              #"
echo "#                 mfaraj57  &  RAED                     #"              
echo "#                     support                           #"
echo "#   https://www.tunisia-sat.com/forums/threads/3896466/ #"
echo "#########################################################"
echo "#           your Device will RESTART Now                #"
echo "#########################################################"
sleep 3
killall -9 enigma2 
exit 0
