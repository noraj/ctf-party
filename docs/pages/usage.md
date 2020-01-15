# Usage

## Examples of usage

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
