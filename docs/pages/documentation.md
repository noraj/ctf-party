# Documentation 

## Server locally

```
$ npm i docsify-cli -g
$ docsify serve docs
```

## Library doc

The output directory of the library documentation will be `docs/yard`.

You can consult it online [here](https://orange-cyberdefense.github.io/ctf-party/yard/).

### Building locally: for library users

For developers who only want to use the library.

```
$ bundle exec yard doc
```

### Building locally: for developer

For developers who want to participate to the development.

```
$ bundle exec yard doc --yardopts .yardopts-dev
```
