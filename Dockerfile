FROM ruby:2.1
MAINTAINER Woodland Hunter <tech@sitereliability.engineer>

RUN apt-get update \
  && apt-get install -y \
    node \
    python-pygments \
    openjdk-7-jre \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/
VOLUME /src
RUN aws s3 cp s3://jkyll-docker/s3_website.yml /src/s3_website.yml
RUN mkdir -p /usr/install
RUN mkdir -p /src/_posts
WORKDIR /usr/install
COPY Gemfile /usr/install
COPY Gemfile.lock /usr/install
RUN bundle install

ADD https://github.com/laurilehmijoki/s3_website/releases/download/v2.12.1/s3_website.jar /usr/local/bundle/gems/s3_website-2.12.1/s3_website-2.12.1.jar

EXPOSE 4000

WORKDIR /src
