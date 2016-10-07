FROM ruby:2.3.1

COPY ["entrypoint.sh", "/usr/local/bin/"] 


RUN apt-get update && \
  apt-get upgrade -y && \
  gem install rack && \  
  gem install nanoc && \
  gem install guard-nanoc && \
  mkdir /data && \
  adduser --disabled-password --gecos '' nanoc && \
  chown nanoc /data && \
  chmod +rx /usr/local/bin/entrypoint.sh

USER nanoc

# place to persist gems
VOLUME /usr/local/bundle/

WORKDIR /data

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
CMD ["live"]
