FROM ruby:2.6.0
RUN mkdir /convertion-testing
WORKDIR /convertion-testing
ADD . /convertion-testing
RUN gem update bundler
RUN bundle install --without test development
