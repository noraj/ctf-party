# Installation

## Production

<!-- tabs:start -->

### **rubygems.org**

```bash
gem install ctf-party
```

Gem: [ctf-party](https://rubygems.org/gems/ctf-party)

### **BlackArch**

From the repository:

```bash
pacman -S ctf-party
```

From git:

```bash
blackman -i ctf-party
```

PKGBUILD: [ctf-party](https://github.com/BlackArch/blackarch/blob/master/packages/ctf-party/PKGBUILD)

### **ArchLinux**

Manually:

```bash
git clone https://aur.archlinux.org/ruby-ctf-party.git
cd ruby-ctf-party
makepkg -sic
```

With an AUR helper ([Pacman wrappers](https://wiki.archlinux.org/index.php/AUR_helpers#Pacman_wrappers)), eg. pikaur:

```bash
pikaur -S ruby-ctf-party
```

AUR: [ruby-ctf-party](https://aur.archlinux.org/packages/ruby-ctf-party/)

### **Docker (git)**

Without a registry

```bash
git clone https://github.com/noraj/ctf-party.git
cd ctf-party
docker-compose build
# alternatively without docker compose
docker build -f Dockerfile -t ctf-party --build-arg ctf-party_VERSION=4.0.0 .
```

Usage examples:

```bash
docker-compose run --rm ctf-party ctf-party 'security' to_hex
docker-compose run --rm ctf-party ctf-party_console
# alternatively without docker compose
docker run -it --rm ctf-party ctf-party 'security' to_hex
docker run -it --rm ctf-party ctf-party_console
```

### **Docker (Docker Hub)**

host: `docker.io`

```bash
# latest
docker pull noraj/ctf-party

# specific tag
docker pull noraj/ctf-party:4.0.0
```

Repository: [noraj/ctf-party](https://hub.docker.com/r/noraj/ctf-party).

### **Docker (GHCR)**

GHCR = Github Container Registry

host: `ghcr.io`

```bash
# latest
docker pull ghcr.io/noraj/ctf-party

# specific tag
docker pull ghcr.io/noraj/ctf-party:4.0.0
```

Repository: [noraj/ctf-party](https://github.com/noraj/ctf-party/pkgs/container/ctf-party)

### **Docker (ACR)**

ACR = Alibaba Cloud Container Registry

host: `registry-intl.eu-central-1.aliyuncs.com`

```bash
# latest
docker pull registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party

# specific tag
docker pull registry-intl.eu-central-1.aliyuncs.com/noraj/ctf-party:4.0.0
```

Repository: [the overview page is not public](https://cr.console.aliyun.com/repository/eu-central-1/noraj/ctf-party/details)

### **Docker (Quay)**

host: `quay.io`

```bash
# latest
docker pull quay.io/noraj/ctf-party

# specific tag
docker pull quay.io/noraj/ctf-party:4.0.0
```

Repository: [noraj/ctf-party](https://quay.io/repository/noraj/ctf-party?tab=info)

<!-- tabs:end -->

## Development

It's better to use [ASDM-VM](https://asdf-vm.com/) to have latests version of ruby and to avoid trashing your system ruby.

<!-- tabs:start -->

### **rubygems.org**

```
$ gem install --development ctf-party
```

### **git**

Just replace `4.0.0` with the gem version you see after `gem build`.

```bash
git clone https://github.com/noraj/ctf-party.git ctf-party
cd ctf-party
gem install bundler
bundler install
gem build ctf_party.gemspec
gem install ctf-party-4.0.0.gem
```

Note: if an automatic install is needed you can get the version with `$ gem build ctf_party.gemspec | grep Version | cut -d' ' -f4`.

### **No install**

Run the library in irb without installing the gem.

From local file (lib):

```bash
irb -Ilib -rctf_party
```

From local file (CLI):

```bash
ruby -Ilib -rctf_party bin/ctf-party
```

From the installed gem:

```bash
ctf-party_console
```

<!-- tabs:end -->
