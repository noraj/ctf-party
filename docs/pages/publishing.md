# Publishing

Be sure all **tests** pass!

```
$ bundle exec rake test
```

Also check the **linter**:

```
$ bundle exec rubocop
```

On new release don't forget to rebuild the **library documentation**:

```
$ bundle exec yard doc
```

Create an **annotated git tag**:

```
$ git tag -a vx.x.x
```

Push the changes including the tags:

```
$ git push --follow-tags
```

Build the **gem**:

```
$ gem build ctf_party.gemspec
# or
$ bundle exec rake build
```

Push the new gem release on **RubyGems** See https://guides.rubygems.org/publishing/.

```
$ gem push ctf-party-x.x.x.gem
```

## Docker container registries

<!-- tabs:start -->

### **Docker Hub**

```
$ docker build -f Dockerfile -t noraj/ctf-party:x.x.x --build-arg CTF_PARTY_VERSION=x.x.x .
$ docker login docker.io
$ docker push docker.io/noraj/ctf-party:x.x.x
$ docker push docker.io/noraj/ctf-party
```

### **Github (GHCR)**

GHCR = Github Container Registry

```
$ docker build -f Dockerfile -t ghcr.io/noraj/ctf-party:x.x.x --build-arg CTF_PARTY_VERSION=x.x.x .

$ export CR_PAT=YOUR_TOKEN
$ echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

$ pass show docker-credential-helpers/Z2hjci5pbw==/USERNAME
$ docker push ghcr.io/noraj/ctf-party:x.x.x
$ docker push ghcr.io/noraj/ctf-party
```

### **Alibaba Cloud (ACR)**

ACR = Alibaba Cloud Container Registry

```
$ docker build -f Dockerfile -t registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:x.x.x --build-arg CTF_PARTY_VERSION=x.x.x .

$ docker login registry-intl.eu-central-1.aliyuncs.com

$ pass show docker-credential-helpers/cmVnaXN0cnktaW50bC5ldS1jZW50cmFsLTEuYWxpeXVuY3MuY29t/USERNAME
$ docker push registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:x.x.x
$ docker push registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party
```

<!-- tabs:end -->
