# Changelog

## [3.0.0 - Unreleased]

- **Breaking changes**
  - **Drop Ruby 2.7 support** because there is no `URI:WS` and `URI:WSS` used for `defang_uri` and anyway [official support has ended too](https://www.ruby-lang.org/en/downloads/branches/)
  - `hex2bin` now returns even number of chars (pad with `0`) by default and add an option to disable it.
- Changes:
  - Renamed `from_hexip` to `from_hexipv4` and created an aliases `from_hexip` for `from_hexipv4`. Same for `to_hexipv4` and bang methods.
  - add options support for all decimal methods and aliases
- New methods: `from_hexipv6` and `from_hexipv6!`
- Fix:
  - bin2hex: fix odd byte cropping issue

## [2.3.0]

- New defang methods:
  - `defang_ip` & `refang_ip` & bang version
  - `defang_domain` & `refang_domain` & bang version
  - `defang_uri` & `refang_uri` & bang version
  - `defang_email` & `refang_email` & bang version
- New network methods:
  - `ipv4?`, `ipv6?`, `ip?`, `uri?`, `domain?`, `email?`
- Chore:
  - Add support for Ruby 3.2

## [2.2.0]

- CLI:
  - Add `urlencode_component` and `urldecode_component` to the command whitelist
  - Now can read from STDIN
  - Add some commands from native String class: `bytesize`, `capitalize`, `chomp`, `chop`, `downcase`, `dump`, `hex`, `inspect`, `length`, `lstrip`, `reverse`, `rstrip`, `scrub`, `shellescape`, `size`, `squeeze`, `strip`, `succ`, `swapcase`, `undump`, `unicode_normalize`, `upcase`
  - Add `--row` option: apply the transformation to each row
  - Add `--file` option: interpret the string as a filename (read from file)
- Fix:
  - dec2hex: fix odd byte cropping issue

## [2.1.0]

- Chore:
  - Add support for Ruby 3.1
  - Update ruby version in Dockerfile
- Documentation:
  - Add `pass` unlock step to build docker (DockerHub) for the publishing page

## [2.0.0]

- New options:
  - `dec2hex`, `to_hex`, `bin2hex`, `to_hexip`: Add a `:prefixall` option, allowing to prefix each byte
- Changes:
  - `dec2hex`: Change the default value of the `:padding` option to `2`
  - `urlencode`, `urldecode`: **BREAKING CHANGE** now use `URI::Parser.new.escape` to get valid URL, use `urlencode_component`, `urldecode_component` to get the old behavior
  - **BREAKING CHANGE** the binary `ctf_party_console` has been renamed to `ctf-party_console`
- New methods:
  - `urlencode_component`, `urldecode_component`: URL-encode URL component, have the old `urlencode`, `urldecode` behavior
- Fixes:
  - `dec2hex`: Fix `:padding` option behavior
  - `hex2dec`, `from_hex`, `hex2bin`, `from_hexip`: Fix `:prefix` behavior when there is one prefix per byte
- Chore:
  - Fix some linting
  - Documentation: Use a new dark theme + use tabs
- Dependencies:
  - Update to yard [v0.9.27](https://github.com/lsegal/yard/releases/tag/v0.9.27)
    - Move from Redcarpet to CommonMarker markdown provider
    - Move doc syntax from Rdoc to markdown
  - Move dev dependencies from gemspec to gemfile

## [1.5.0]

- new rot method:
  - `rot_all` return a hash with all rot possibilities
- new misc method:
  - `istrip` remove/strip all whitespace including inner ones.
- new xor methods:
  - `ulxor` UTF-8 XOR (padding left)
  - `alxor` ASCII XOR (padding left)
  - `urxor` UTF-8 XOR (padding right)
  - `arxor` ASCII XOR (padding right)

## [1.4.1]

- Support more ruby versions
- Support Ruby 3
- Fix some linting

## [1.4.0]

- `ctf-party` CLI tool release

## [1.3.5]

- new dec methods:
  - `to_dec`, `from_dec` & bang version
  - aliases: `dec2str`, `str2dec`

## [1.3.4]

- new hex methods:
  - `from_hexip`, `to_hexip` & bang version
- introduce leet method:
  - `leet` & bang version
- tests: install `minitest-skip` to have a proper way to skip tests

## [1.3.3]

- new bin methods:
  - `to_bin`, `from_bin` & bang version
  - aliases: `str2bin`, `bin2str`
- dependencies: update
- rubocop: rules update

## [1.3.2]

- new cgi methods:
  - `urlencode`, `urldecode` & bang version
  - `htmlescape`, `htmlunescape` & bang version

## [1.3.1]

- hex: add aliases
  - `str2hex` for `to_hex`, idem for bang version
  - `hex2str` for `from_hex`, idem for bang version

## [1.3.0]

- new case methods:
  - normal: `randomcase`, `alternatecase`
  - in-place: `randomcase!`, `alternatecase!`

## [1.2.1]

- lib: code lint
- repo: From from [Orange-Cyberdefense/rabid](https://github.com/Orange-Cyberdefense/rabid) to [noraj/rabid](https://github.com/noraj/rabid/)
- dependencies: update
- rubocop: new rules for new cops
- deprecation: now requires ruby 2.7+ instead of 2.4+

## [1.2.0]

- new hexadecimal methods:
  - normal: `hex2bin`, `bin2hex`
  - in-place: `hex2bin!`, `bin2hex!`

**Chore**

- Updated dependencies
- Updated rubocop rules

## [1.1.0]

**Features**

- new hexadecimal methods:
  - normal: `hex2dec`, `dec2hex`, `to_hex`, `from_hex`
  - in-place: `hex2dec!`, `dec2hex!`, `to_hex!`, `from_hex!`

**Code**

- `to_b64!` and `from_b64!` code simplification
- yard internal references from implicit to explicit

**Chore**

- Updated dependencies
- Updated rubocop rules

## [1.0.0]

- Initial version
