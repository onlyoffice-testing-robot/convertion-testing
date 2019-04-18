FROM ruby:2.6.0
ENV S3_KEY ""
ENV S3_PRIVATE_KEY ""
ENV PALLADIUM_TOKEN ""

RUN apt update && apt install -y libmagic-dev
RUN gem install bundler
RUN gem update --system
RUN mkdir /testing-x2t
WORKDIR /testing-x2t
ADD . /testing-x2t
RUN bundler install
