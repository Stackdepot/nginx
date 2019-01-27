FROM nginx

RUN apt-get update -y && \
    apt-get install curl gnupg2 procps -y && \ 
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs  && \
    npm install -g livereload && \
    mkdir -p /.stack/app && \
    chmod 777 /.stack/app && \
    mkdir -p /var/log/livereload && \
    chmod 777 /var/log/livereload

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# add local files
COPY root/ /

ADD ./config /etc/nginx/conf.d/default.conf
ADD ./servers /.stack/app/
ADD ./oc.sh /var/lib/dupper/onconnect
ADD ./od.sh /var/lib/dupper/ondisconnect

ENV PORT=3000
EXPOSE 80
EXPOSE 443

CMD ["/init", "nginx", "-g", "daemon off;"]
