# Official verified image
FROM ruby:3.1.1-alpine3.15

# Remote git repository <-> Remote container registry
LABEL org.opencontainers.image.source https://github.com/noraj/ctf-party
# Other metadata
LABEL org.opencontainers.image.authors "noraj (Alexandre ZANNI)"
LABEL org.opencontainers.image.documentation https://noraj.github.io/ctf-party/
LABEL org.opencontainers.image.licenses MIT
LABEL org.opencontainers.image.description "A CLI tool & library to enhance and speed up script/exploit writing with string conversion/manipulation."

ARG CTF_PARTY_VERSION
LABEL org.opencontainers.image.version $CTF_PARTY_VERSION

## INSTALL ##
# Install the app
RUN gem install ctf-party -v $CTF_PARTY_VERSION --no-document

## BUILD ##

# drop privileges
RUN adduser -s /bin/true -u 1337 -D -H noraj
USER noraj

CMD ["/usr/local/bundle/bin/ctf-party_console"]
