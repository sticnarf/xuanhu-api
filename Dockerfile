FROM ruby:2.5

ENV RAILS_ENV='production'
ENV RAKE_ENV='production'
ENV RAILS_SERVE_STATIC_FILES='YES'


RUN sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev git curl 
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

RUN git clone https://github.com/Bokjan/XuanhuFE.git --depth=1
RUN cd XuanhuFE && cnpm install && cnpm run build 

RUN mkdir /xuanhu-api
COPY Gemfile /xuanhu-api/Gemfile
WORKDIR /xuanhu-api
RUN bundle install
COPY . /xuanhu-api
RUN cp -r /XuanhuFE/build/* ./public/
RUN bundle install
RUN ruby cdn.rb
RUN rake assets:precompile