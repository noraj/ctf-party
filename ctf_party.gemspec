# frozen_string_literal: true

require_relative 'lib/ctf_party/version'

Gem::Specification.new do |s|
  s.name          = 'ctf-party'
  s.version       = Version::VERSION
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'A library to enhance and speed up script/exploit writing'\
                    ' for CTF players'
  s.description   = 'A library to enhance and speed up script/exploit writing'\
                    'for CTF players (or security researchers, bug bounty'\
                    'hunters, pentesters but mostly focused on CTF) by'\
                    'patching the String class to add a short syntax of usual'\
                    ' code patterns.'
  s.authors       = ['Alexandre ZANNI']
  s.email         = 'alexandre.zanni@engineer.com'
  s.homepage      = 'https://noraj.github.io/ctf-party/'
  s.license       = 'MIT'

  s.files         = Dir['lib/**/*.rb'] + Dir['bin/*'] + ['LICENSE.txt']
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.metadata = {
    'yard.run'          => 'yard',
    'bug_tracker_uri'   => 'https://github.com/noraj/ctf-party/issues',
    'changelog_uri'     => 'https://github.com/noraj/ctf-party/blob/master/docs/CHANGELOG.md',
    'documentation_uri' => 'https://noraj.github.io/ctf-party/',
    'homepage_uri'      => 'https://noraj.github.io/ctf-party/',
    'source_code_uri'   => 'https://github.com/noraj/ctf-party/'
  }

  s.required_ruby_version = '~> 2.7'

  s.add_development_dependency('bundler', '~> 2.1')
  s.add_development_dependency('commonmarker', '~> 0.20') # for GMF support in YARD
  s.add_development_dependency('github-markup', '~> 3.0') # for GMF support in YARD
  s.add_development_dependency('minitest', '~> 5')
  s.add_development_dependency('minitest-skip', '~> 0.0')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('redcarpet', '~> 3.5') # for GMF support in YARD
  s.add_development_dependency('rubocop', '~> 1.8')
  s.add_development_dependency('yard', '~> 0.9')
end
