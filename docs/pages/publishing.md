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
$ git tag -a v3.0.0
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
$ gem push ctf-party-3.0.0.gem
```

## Docker container registries

<!-- tabs:start -->

### **Docker Hub**

```
$ export CTF_PARTY_VERSION=3.0.0
$ docker build -f Dockerfile -t noraj/ctf-party:$CTF_PARTY_VERSION --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .
$ docker build -f Dockerfile -t noraj/ctf-party:latest --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .

$ docker login docker.io

$ pass show docker-credential-helpers/aHR0cHM6Ly9pbmRleC5kb2NrZXIuaW8vdjEv/USERNAME
$ docker push docker.io/noraj/ctf-party:$CTF_PARTY_VERSION
$ docker push docker.io/noraj/ctf-party:latest
```

### **Github (GHCR)**

GHCR = Github Container Registry

```
$ export CTF_PARTY_VERSION=3.0.0
$ docker build -f Dockerfile -t ghcr.io/noraj/ctf-party:$CTF_PARTY_VERSION --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .
$ docker build -f Dockerfile -t ghcr.io/noraj/ctf-party:latest --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .

$ export CR_PAT=YOUR_TOKEN
$ echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

$ pass show docker-credential-helpers/Z2hjci5pbw==/USERNAME
$ docker push ghcr.io/noraj/ctf-party:$CTF_PARTY_VERSION
$ docker push ghcr.io/noraj/ctf-party:latest
```

### **Alibaba Cloud (ACR)**

ACR = Alibaba Cloud Container Registry

```
$ export CTF_PARTY_VERSION=3.0.0
$ docker build -f Dockerfile -t registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:$CTF_PARTY_VERSION --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .
$ docker build -f Dockerfile -t registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:latest --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .

$ docker login registry-intl.eu-central-1.aliyuncs.com

$ pass show docker-credential-helpers/cmVnaXN0cnktaW50bC5ldS1jZW50cmFsLTEuYWxpeXVuY3MuY29t/USERNAME
$ docker push registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:$CTF_PARTY_VERSION
$ docker push registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:latest
```

### **Quay.io**

```
$ export CTF_PARTY_VERSION=3.0.0
$ docker build -f Dockerfile -t quay.io/noraj/ctf-party:$CTF_PARTY_VERSION --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .
$ docker build -f Dockerfile -t quay.io/noraj/ctf-party:latest --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .

$ docker login quay.io

$ pass show docker-credential-helpers/cXVheS5pbw==/USERNAME
$ docker push quay.io/noraj/ctf-party:$CTF_PARTY_VERSION
$ docker push quay.io/noraj/ctf-party:latest
```

<!-- tabs:end -->
