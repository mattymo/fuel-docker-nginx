#!/bin/bash
puppet apply -v /root/site.pp
mkdir -p /var/www/nailgun/dump
chmod -R 755 /var/www/nailgun/dump
nginx -g 'daemon off;'
