#!/bin/sh -e
#
# nb-protocol installer
#

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
NC=$(tput sgr0)

# remove the service scripts
if [ ! -f /usr/local/bin/xdebug-netbeans-bridge/xdebug-netbeans-bridge.php ]; then
    echo $RED "ERROR:" $NC "xdebug-netbeans-bridge already removed."
else
    rm -rf /usr/local/bin/xdebug-netbeans-bridge
fi

# remove init script
if [ ! -f /etc/init/xdebug-netbeans-bridge.conf ]; then
    echo $RED "ERROR:" $NC 'xdebug-netbeans-bridge startup script already removed.'
else
    rm /etc/init/xdebug-netbeans-bridge.conf
fi

# remove log file
if [ ! -f /var/log/xdebug-netbeans-bridge.log ]; then
    echo $RED "ERROR:" $NC 'xdebug-netbeans-bridge.log already removed.'
else
    rm /var/log/xdebug-netbeans-bridge.log
fi

echo $GREEN 'OK' $NC  'xdebug-netbeans-bridge removed successfully.'