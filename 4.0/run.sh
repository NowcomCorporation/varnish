#!/bin/bash

if [ ! -z "$CONTENT_VCL" ]; then
	echo -e "$CONTENT_VCL" > /etc/varnish/default.vcl
	CONTENT="-f /etc/varnish/default.vcl"
fi

echo "Start varnishd"
exec /usr/sbin/varnishd -a :$LISTEN_PORT $CONTENT -n $VARNISH_NAME -s $CACHE -S /etc/varnish/secret -F $VARNISH_OPTS &

# Dashboard for Varnish Agent2
if [ "$ENABLE_DASHBOARD" == "True" ]
then
  # wait for varnishd to startup
  sleep 20
  
  echo "start varnish-agent"
  varnish-agent -H /var/www/dashboard/ -c 8888 -n $VARNISH_NAME -p /etc/varnish/ -z 127.0.0.1:80 -d -v
fi

varnishlog -n $VARNISH_NAME -w /var/log/varnish/varnish.log
