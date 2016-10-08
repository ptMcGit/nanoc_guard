FROM ruby:2.3.1

COPY ["entrypoint.sh", "/usr/local/bin/"]

# place to persist gems

VOLUME /usr/local/bundle/

RUN \
    chmod +rx /usr/local/bin/entrypoint.sh && \
    apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    adduser --disabled-password --gecos '' nanoc && \
    mkdir /data && \
    chown -R nanoc:nanoc /usr/local/bundle/ /data

USER nanoc

RUN \
    gem install rack && \
    gem install nanoc && \
    gem install guard-nanoc

WORKDIR /data

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
CMD ["live"]
