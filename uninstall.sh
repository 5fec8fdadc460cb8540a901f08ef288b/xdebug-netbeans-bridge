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
if [ ! -f /usr/local/bin/xdebug-nb-bridge/xdebug-nb-bridge.php ]; then
    echo $RED "ERROR:" $NC "xdebug-nb-bridge already removed."
else
    rm -rf /usr/local/bin/xdebug-nb-bridge
fi

# remove init script
if [ ! -f /etc/init/xdebug-nb-bridge.conf ]; then
    echo $RED "ERROR:" $NC 'xdebug-nb-bridge startup script already removed.'
else
    rm /etc/init/xdebug-nb-bridge.conf
fi

# remove log file
if [ ! -f /var/log/xdebug-nb-bridge.log ]; then
    echo $RED "ERROR:" $NC 'xdebug-nb-bridge.log already removed.'
else
    rm /var/log/xdebug-nb-bridge.log
fi

echo $GREEN 'OK' $NC  'xdebug-nb-bridge removed successfully.'