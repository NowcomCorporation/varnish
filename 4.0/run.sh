#!/bin/bash
if [ ! -z "$CONTENT_VCL" ]; then
	echo -e "$CONTENT_VCL" > /etc/varnish/default.vcl
	CONTENT="-f /etc/varnish/default.vcl"
fi
(sleep 10; /etc/init.d/varnishncsa start) & 
exec /usr/sbin/varnishd -a :$LISTEN_PORT $CONTENT -s $CACHE -S /etc/varnish/secret -F $VARNISH_OPTS &
tail -f /var/log/varnish/varnishncsa.log

