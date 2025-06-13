# ctf-party

[![Gem Version](https://badge.fury.io/rb/ctf-party.svg)](https://badge.fury.io/rb/ctf-party)
![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/noraj/ctf-party)
[![GitHub forks](https://img.shields.io/github/forks/noraj/ctf-party)](https://github.com/noraj/ctf-party/network)
[![GitHub stars](https://img.shields.io/github/stars/noraj/ctf-party)](https://github.com/noraj/ctf-party/stargazers)
[![GitHub license](https://img.shields.io/github/license/noraj/ctf-party)](https://github.com/noraj/ctf-party/blob/master/LICENSE.txt)
[![Rawsec's CyberSecurity Inventory](https://inventory.raw.pm/img/badges/Rawsec-inventoried-FF5050_flat.svg)](https://inventory.raw.pm/tools.html#ctf-party)

[![Packaging status](https://repology.org/badge/vertical-allrepos/ctf-party.svg)](https://repology.org/project/ctf-party/versions)

![](https://noraj.github.io/ctf-party/_media/logo.png)


## What it is

A CLI tool & library to enhance and speed up script/exploit writing for CTF players (or
security researchers, bug bounty hunters, pentesters but mostly focused on CTF)
by patching the String class to add a short syntax of usual code patterns.
The philosophy is also to keep the library to be pure native ruby (no dependencies)
and not to re-implement what another library is already doing well.

For example instead of writing:

```ruby
require 'base64'

myvar = 'string'
myvar = Base64.strict_encode64(myvar)
```

Just write (shorter and easier to remember):

```ruby
require 'ctf_party'

myvar = 'string'
myvar.to_b64!
```

Most of the methods are available as commands CLI tool:

```
$ ctf-party 'security' to_hex
7365637572697479

$ ctf-party 'NzQ2Zjc0NmY=' from_b64 hex2str str2bin
01110100011011110111010001101111
```

## Features

[See here](https://noraj.github.io/ctf-party/#/pages/features).

## References

[Homepage / Documentation](https://noraj.github.io/ctf-party/).

## Author

Made by Alexandre ZANNI ([@noraj](https://pwn.by/noraj/)). Forked from [Orange-Cyberdefense/ctf-party](https://github.com/Orange-Cyberdefense/ctf-party).
