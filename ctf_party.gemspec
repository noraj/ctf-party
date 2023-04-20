# frozen_string_literal: true

require_relative 'lib/ctf_party/version'

Gem::Specification.new do |s|
  s.name          = 'ctf-party'
  s.version       = Version::VERSION
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'A CLI tool & library to enhance and speed up script/exploit ' \
                    'writing with string conversion/manipulation'
  s.description   = 'A CLI tool & library to enhance and speed up script/exploit ' \
                    'writing for CTF players (or security researchers, bug bounty ' \
                    'hunters, pentesters but mostly focused on CTF) by ' \
                    'patching the String class to add a short syntax of usual ' \
                    'code patterns. Methods for base64, digest (hash), flag, ' \
                    'rot (Caesar), hexadecimal, case, cgi (URL encoding/decoding, ' \
                    'HTML escaping/unescaping), binary, leet (1337), decimal, ' \
                    'XOR, whitespace strip, IP/URI/domain/email defang/refang.'
  s.authors       = ['Alexandre ZANNI']
  s.email         = 'alexandre.zanni@engineer.com'
  s.homepage      = 'https://noraj.github.io/ctf-party/'
  s.license       = 'MIT'

  s.files         = Dir['lib/**/*.rb'] + Dir['bin/*'] + ['LICENSE.txt']
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.metadata = {
    'yard.run'              => 'yard',
    'bug_tracker_uri'       => 'https://github.com/noraj/ctf-party/issues',
    'changelog_uri'         => 'https://github.com/noraj/ctf-party/blob/master/docs/CHANGELOG.md',
    'documentation_uri'     => 'https://noraj.github.io/ctf-party/',
    'homepage_uri'          => 'https://noraj.github.io/ctf-party/',
    'source_code_uri'       => 'https://github.com/noraj/ctf-party/',
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = ['>= 3.0.0', '< 4.0']

  s.add_runtime_dependency('docopt', '~> 0.6')
end
