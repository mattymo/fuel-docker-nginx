#!/bin/bash
###Deprecated start
#Set up nginx to listen to specified hosts
#NAILGUN_HOST="${NAILGUN_HOST:-$NAILGUN_PORT_8001_TCP_ADDR:8001}"
#OSTF_HOST="${OSTF_HOST:-$OSTF_PORT_8001_TCP_ADDR:8777}"
#sed -i "s/NAILGUN_SERVER/$NAILGUN_HOST/" /etc/nginx/conf.d/nailgun.conf
#sed -i "s/OSTF_SERVER/$OSTF_HOST/" /etc/nginx/conf.d/nailgun.conf
###Deprecated end

#If launched with volume /etc/fuel
if [ -f /etc/fuel/astute.yaml ]; then
  rm -f /etc/astute.yaml
  ln -s /etc/fuel/astute.yaml /etc/astute.yaml
fi
#if launched with volume /repo
for folder in bootstrap centos eggs gems ubuntu; do
  if [ -d "/repo/$folder" ]; then 
    rm -f "/var/www/nailgun/$folder"
    ln -s "/repo/$folder" "/var/www/nailgun/$folder"
  fi
done

puppet apply -v /root/site.pp

chmod -R 755 /var/www/nailgun/dump

nginx -g 'daemon off;'
