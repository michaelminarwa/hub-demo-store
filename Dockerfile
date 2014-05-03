FROM ubuntu:12.04
MAINTAINER Ric Lister, ric@spreecommerce.com

RUN apt-get update
RUN apt-get -y install build-essential zlib1g-dev libreadline6-dev libyaml-dev libssl-dev

## grab a nice friendly ruby package
ADD https://33a6871815e79f57702b-41c4a87573b0a371a9ac50d3802e995d.ssl.cf2.rackcdn.com/ruby2.0_2.0.0-p451_amd64.deb /tmp/
RUN dpkg -i /tmp/ruby2.0_2.0.0-p451_amd64.deb

## deps for bundle
RUN apt-get -y install git libpq-dev libsqlite3-dev nodejs imagemagick
RUN gem install bundler --no-rdoc --no-ri

## hack so docker can cache bundle if Gemfile has not changed
WORKDIR /tmp 
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install 

## deploy code to /app
ADD ./ /app
WORKDIR /app

## setup script for initial seeding database
## run this with docker run hub-demo ./setup.sh
RUN echo \
    "#!/bin/sh\n" \
    "rake railties:install:migrations\n" \
    "rake db:migrate\n" \
    "rake db:seed\n" \
    "rake spree_sample:load" > setup.sh && chmod 0755 setup.sh

## expose rails (for testing) and unicorn port
EXPOSE 3000 5000

## bundle exec all the things
ENTRYPOINT [ "bin/bundle", "exec" ]

CMD [ "foreman", "start" ]
