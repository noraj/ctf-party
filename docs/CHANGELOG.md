# Changelog

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
