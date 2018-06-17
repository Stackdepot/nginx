FROM nginx

ADD ./template /template
ADD ./oc.sh /var/lib/dupper/onconnect
ADD ./od.sh /var/lib/dupper/ondisconnect

