FROM tutum/curl
MAINTAINER info@tutum.co

ENV VERSION 4.0
RUN apt-get update && apt-get install -yq apt-transport-https ca-certificates
RUN curl -L https://packagecloud.io/varnishcache/varnish41/gpgkey | sudo apt-key add - && \
        echo "deb https://packagecloud.io/varnishcache/varnish41/ubuntu/ trusty main" >> /etc/apt/sources.list.d/varnish-cache.list && \
	apt-get update && \
	apt-get install -yq varnish && apt-get install -yq varnish-agent && \
        groupadd varnishlog && usermod -G varnishlog varnish && \

        mkdir -p /var/www/dashboard && cd /var/www/dashboard

# Port where varnish will bind to
ENV LISTEN_PORT 80
# Port where the content backend is listening to
# You can use link names in this variable
ENV BACKEND_PORT 80
ENV CONTENT -b backend:$BACKEND_PORT
# Or, if you want to use a VCL file, use the following:
#ENV CONTENT -f /etc/varnish/default.vcl
# Or, if you want to use a VCL file by passing the contents, use the following:
#ENV CONTENT_VCL <CONTENTS_OF_VCL_FILE>

## Which cache storage to use
# File based:
ENV CACHE file,/var/lib/varnish/varnish_storage.bin,256m
# Memory based:
#ENV CACHE malloc,256m

# enable logging to file for Varnish
ENV VARNISHNCSA_ENABLED 1

# set Title for Varnish Dashboard
ENV DASHBOARD_TITLE "Varnish Cache"
ENV ENABLE_DASHBOARD True

ADD ./dashboard /var/www/dashboard/

VOLUME /var/lib/varnish

ADD run.sh /run.sh
CMD ["/run.sh"]
