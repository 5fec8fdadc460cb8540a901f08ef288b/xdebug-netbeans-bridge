xdebug-netbeans-bridge
======================

An upstart service that allows xdebug backtrace links to trigger navigation events in Netbeans. 

This works for PHP stack trace link navigation in Chrome and other browsers which do not support custom protocol handlers. Runs on port 9004 by default.

Firefox does, and you don't need this script if you don't mind working
out of Firefox. There you can setup custom protocol handlers in about:config. 

Tested with Ubuntu 14.04

## Start \ Stop

- Not necessary to start script after installed. Runs at startup.

```
service xdebug-nb-bridge start
service xdebug-nb-bridge stop
```

## Installing: 

```
sudo sh install.sh
```

## Configuring: 

### Change php.ini

- Format Xdebug backtrace links in all relevant php.ini files to redirect to this service (which runs on port 9004): 

```
xdebug.file_link_format = "http://localhost:9004/nb-protocol-server.php?file=%f&line=%l"
```

## Uninstalling: 

```
sudo sh uninstall.sh
```