# Installation

## Production

### Install from rubygems.org

```
$ gem install ctf-party
```

Gem: [ctf-party](https://rubygems.org/gems/ctf-party)

### Install from BlackArch

From the repository:

```
# pacman -S ruby-ctf-party
```

From git:

```
# blackman -i ruby-ctf-party
```

PKGBUILD: [ruby-ctf-party](https://github.com/BlackArch/blackarch/blob/master/packages/ruby-ctf-party/PKGBUILD)

### Install from ArchLinux

Manually:

```
$ git clone https://aur.archlinux.org/ruby-ctf-party.git
$ cd ruby-ctf-rabid
$ makepkg -sic
```

With an AUR helper ([Pacman wrappers](https://wiki.archlinux.org/index.php/AUR_helpers#Pacman_wrappers)), eg. pikaur:

```
$ pikaur -S ruby-ctf-rabid
```

AUR: [ruby-ctf-rabid](https://aur.archlinux.org/packages/ruby-ctf-rabid/)

## Development

It's better to use [rbenv](https://github.com/rbenv/rbenv) to have latests version of ruby and to avoid trashing your system ruby.

### Install from rubygems.org

```
$ gem install --development ctf-party
```

### Build from git

Just replace `x.x.x` with the gem version you see after `gem build`.

```
$ git clone https://github.com/Orange-Cyberdefense/ctf-party.git rabid
$ cd ctf-party
$ gem install bundler
$ bundler install
$ gem build ctf_party.gemspec
$ gem install ctf-party-x.x.x.gem
```

Note: if an automatic install is needed you can get the version with `$ gem build ctf_party.gemspec | grep Version | cut -d' ' -f4`.

### Run the library in irb without installing the gem

From local file:

```
$ irb -Ilib -rctf_party
```

From the installed gem:

```
$ ctf_party_console
```
