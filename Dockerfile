FROM ruby:2.3
MAINTAINER Woodland Hunter <tech@sitereliability.engineer>
RUN apt-get install wget
RUN apt-get install unzip
RUN git clone https://github.com/mohanishsalunkhe/dockyll-s3.git
RUN cd dockyll-s3
RUN wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
RUN apt-get update \
  && apt-get install -y \
    nodejs \
    python-pygments \
    openjdk-8-jre \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/
VOLUME /tmp
RUN mkdir -p /usr/install
RUN mkdir -p /src/_posts
RUN ls -l /src/
ADD /tmp/s3_website.yml /src/s3_website.yml
WORKDIR /usr/install
COPY Gemfile /usr/install
COPY Gemfile.lock /usr/install
RUN bundle install
#
ADD https://github.com/laurilehmijoki/s3_website/releases/download/v2.12.1/s3_website.jar /usr/local/bundle/gems/s3_website-2.12.1/s3_website-2.12.1.jar
#
EXPOSE 4000
#
WORKDIR /src
