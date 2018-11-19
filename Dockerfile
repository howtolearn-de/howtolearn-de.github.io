FROM ubuntu:latest
COPY . /src
WORKDIR /src

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.en \
    LC_ALL=en_US.UTF-8 \
    GEM_HOME=$HOME/gems \
    PATH=$HOME/gems/bin:$PATH

RUN apt-get update
RUN apt-get install -y make nodejs npm build-essential ruby ruby-dev locales
RUN echo "en_US UTF-8 > /etc/locale.gen"
RUN locale-gen en_US.UTF-8

RUN npm install 
RUN npm install --global pug
RUN gem install bundler
RUN bundle install
VOLUME /src/dist
#ENTRYPOINT "printenv"

EXPOSE 4000
ENTRYPOINT ["/gems/bin/jekyll"]
CMD ["build"]
