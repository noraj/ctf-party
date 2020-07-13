# ctf-party

[![Gem Version](https://badge.fury.io/rb/ctf-party.svg)](https://badge.fury.io/rb/ctf-party)
![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/noraj/ctf-party)
[![GitHub forks](https://img.shields.io/github/forks/noraj/ctf-party)](https://github.com/noraj/ctf-party/network)
[![GitHub stars](https://img.shields.io/github/stars/noraj/ctf-party)](https://github.com/noraj/ctf-party/stargazers)
[![GitHub license](https://img.shields.io/github/license/noraj/ctf-party)](https://github.com/noraj/ctf-party/blob/master/LICENSE.txt)
[![Rawsec's CyberSecurity Inventory](https://inventory.rawsec.ml/img/badges/Rawsec-inventoried-FF5050_flat.svg)](https://inventory.rawsec.ml/tools.html#ctf-party)

## What it is

A library to enhance and speed up script/exploit writing for CTF players (or
security researchers, bug bounty hunters, pentesters but mostly focused on CTF)
by patching the String class to add a short syntax of usual code patterns.
The philosophy is also to keep the library to be pure ruby (no dependencies)
and not to re-implement what another library is already doing well
(eg. [xorcist] for xor).

[xorcist]:https://github.com/fny/xorcist

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

## Features

- base64: `to_b64`, `to_b64!`, `from_b64`, `from_b64!`, `b64?`
- digest: `md5`, `md5!`, `sha1`, `sha1!`, etc.
- flag: `flag`, `flag!`, `flag?` (apply/check a flag format)
- rot: `rot`, `rot!`, `rot13`, `rot13!`
- hex: `hex2dec`, `dec2hex`, `to_hex`, `from_hex`, `hex2bin`, `bin2hex` and bang versions

## References

Homepage / Documentation: https://noraj.github.io/ctf-party/

## Author

Made by Alexandre ZANNI ([@noraj](https://pwn.by/noraj/)).
