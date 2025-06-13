# Documentation 

## Server locally

```bash
npm i docsify-cli -g
docsify serve docs
```

## Library doc

The output directory of the library documentation will be `docs/yard`.

You can consult it online [here](https://noraj.github.io/ctf-party/yard/).

### Building locally: for library users

For developers who only want to use the library.

```bash
bundle exec yard doc
```

### Building locally: for developer

For developers who want to participate in the development.

```bash
bundle exec yard doc --yardopts .yardopts-dev
```
