FROM ruby:2.6.0
ENV S3_KEY ""
ENV S3_PRIVATE_KEY ""
ENV PALLADIUM_TOKEN ""

RUN mkdir /convertion-testing
WORKDIR /convertion-testing
ADD . /convertion-testing
RUN gem install bundler
RUN gem update --system
RUN bundler install
