# Publishing

Edit the new version number in:

- `lib/ctf_party/version.rb`
- `docker-compose.yml`
- `docs/pages/install.md`
- `docs/pages/publishing.md`

Be sure all **tests** pass!

```bash
bundle exec rake test
```

Also check the **linter**:

```bash
bundle exec rubocop
```

On new release don't forget to rebuild the **library documentation**:

```bash
bundle exec yard doc
```

Create an **annotated git tag**:

```bash
git tag -a v5.0.0
```

Push the changes including the tags:

```bash
git push --follow-tags
```

Build the **gem**:

```bash
gem build ctf_party.gemspec
# or
bundle exec rake build
```

Push the new gem release on **RubyGems** See https://guides.rubygems.org/publishing/.

```bash
gem push ctf-party-5.0.0.gem
```

## Docker container registries

<!-- tabs:start -->

### **Docker Hub**

```bash
export CTF_PARTY_VERSION=5.0.0
docker build -f Dockerfile -t noraj/ctf-party:$CTF_PARTY_VERSION --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .
docker build -f Dockerfile -t noraj/ctf-party:latest --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .

docker login docker.io

pass show docker-credential-helpers/aHR0cHM6Ly9pbmRleC5kb2NrZXIuaW8vdjEv/USERNAME
docker push docker.io/noraj/ctf-party:$CTF_PARTY_VERSION
docker push docker.io/noraj/ctf-party:latest
```

### **Github (GHCR)**

GHCR = Github Container Registry

```bash
export CTF_PARTY_VERSION=5.0.0
docker build -f Dockerfile -t ghcr.io/noraj/ctf-party:$CTF_PARTY_VERSION --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .
docker build -f Dockerfile -t ghcr.io/noraj/ctf-party:latest --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .

export CR_PAT=YOUR_TOKEN
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

pass show docker-credential-helpers/Z2hjci5pbw==/USERNAME
docker push ghcr.io/noraj/ctf-party:$CTF_PARTY_VERSION
docker push ghcr.io/noraj/ctf-party:latest
```

### **Alibaba Cloud (ACR)**

ACR = Alibaba Cloud Container Registry

```bash
export CTF_PARTY_VERSION=5.0.0
docker build -f Dockerfile -t registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:$CTF_PARTY_VERSION --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .
docker build -f Dockerfile -t registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:latest --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .

docker login registry-intl.eu-central-1.aliyuncs.com

pass show docker-credential-helpers/cmVnaXN0cnktaW50bC5ldS1jZW50cmFsLTEuYWxpeXVuY3MuY29t/USERNAME
docker push registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:$CTF_PARTY_VERSION
docker push registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:latest
```

### **Quay.io**

```bash
export CTF_PARTY_VERSION=5.0.0
docker build -f Dockerfile -t quay.io/noraj/ctf-party:$CTF_PARTY_VERSION --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .
docker build -f Dockerfile -t quay.io/noraj/ctf-party:latest --build-arg CTF_PARTY_VERSION=$CTF_PARTY_VERSION .

docker login quay.io

pass show docker-credential-helpers/cXVheS5pbw==/USERNAME
docker push quay.io/noraj/ctf-party:$CTF_PARTY_VERSION
docker push quay.io/noraj/ctf-party:latest
```

<!-- tabs:end -->
