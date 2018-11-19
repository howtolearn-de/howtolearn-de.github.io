FROM ubuntu:latest
COPY . /src
WORKDIR /src

# Install language pack
#RUN apk --no-cache add ca-certificates wget && \
#    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
#    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && \
#    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-bin-2.25-r0.apk && \
#    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-i18n-2.25-r0.apk && \
#    apk add glibc-bin-2.25-r0.apk glibc-i18n-2.25-r0.apk glibc-2.25-r0.apk
#
#RUN /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8
#
# Set the lang, you can also specify it as as environment variable through docker-compose.yml

#RUN apk add --update nodejs nodejs-npm alpine-sdk
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
ENTRYPOINT ["/gems/bin/jekyll", "build"]
 
