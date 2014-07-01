#!/bin/sh -e
#
# nb-protocol installer
#

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
NC=$(tput sgr0)


# get path of currently executing script
SCRIPT_DIR="`dirname \"$0\"`"              # relative
SCRIPT_DIR="`( cd \"$SCRIPT_DIR\" && pwd )`"  # absolutized and normalized
if [ -z "$SCRIPT_DIR" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

# make scripts executable
chmod +x $SCRIPT_DIR'/xdebug-netbeans-bridge.php'

# install scripts
rm -rf /usr/local/bin/xdebug-netbeans-bridge
mkdir /usr/local/bin/xdebug-netbeans-bridge
cp $SCRIPT_DIR'/xdebug-netbeans-bridge.php' /usr/local/bin/xdebug-netbeans-bridge

# install log
touch /var/log/xdebug-netbeans-bridge.log
chmod 777 /var/log/xdebug-netbeans-bridge.log

# install upstart script
cp $SCRIPT_DIR'/xdebug-netbeans-bridge' /etc/init/xdebug-netbeans-bridge.conf
chmod +x /etc/init/xdebug-netbeans-bridge.conf

echo $GREEN "OK" $NC "Install successful."