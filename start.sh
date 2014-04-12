#!/bin/bash
puppet apply -v /root/site.pp
chmod -R 755 /var/www/nailgun/dump
nginx -g 'daemon off;'
