#!/bin/bash
if [ ! -z "$CONTENT_VCL" ]; then
	echo -e "$CONTENT_VCL" > /etc/varnish/default.vcl
	CONTENT="-f /etc/varnish/default.vcl"
fi

# Dashboard for Varnish Agent2
if [ "$ENABLE_DASHBOARD" == "True" ]
then
  echo "start varnish-agent"
  varnish-agent -H -d /var/www/dashboard/
fi

echo "Start varnishd"
exec /usr/sbin/varnishd -a :$LISTEN_PORT $CONTENT -s $CACHE -S /etc/varnish/secret -F $VARNISH_OPTS

