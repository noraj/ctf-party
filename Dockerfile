# Official verified image
FROM ruby:3.2.1-alpine3.17

# Metadata
LABEL org.opencontainers.image.title="ctf-party" \
      org.opencontainers.image.description="A CLI tool & library to enhance and speed up script/exploit writing with string conversion/manipulation." \
      org.opencontainers.image.authors="noraj (Alexandre ZANNI)" \
      org.opencontainers.image.vendor="noraj (Alexandre ZANNI)" \
      org.opencontainers.image.documentation="https://noraj.github.io/ctf-party/" \
      org.opencontainers.image.source="https://github.com/noraj/ctf-party" \
      org.opencontainers.image.licenses="MIT"

ARG CTF_PARTY_VERSION
LABEL org.opencontainers.image.version="$CTF_PARTY_VERSION"

## INSTALL ##
# Install the app
RUN gem install ctf-party -v $CTF_PARTY_VERSION --no-document

## BUILD ##

# drop privileges
RUN adduser -s /bin/true -u 1337 -D -H noraj
USER noraj

CMD ["/usr/local/bundle/bin/ctf-party_console"]
