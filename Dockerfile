FROM ruby:2.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /cart
WORKDIR /cart
ADD Gemfile /cart/Gemfile
ADD Gemfile.lock /cart/Gemfile.lock
RUN bundle install
ADD . cart
RUN bundle install

