FROM ruby:2.4.3
RUN mkdir /tmp/assets
ENTRYPOINT ["cp -R /var/www/onlyoffice/documentserver/server/FileConverter/bin/* /tmp/assets"]
