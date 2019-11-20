# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ctf_party/version'

Gem::Specification.new do |s|
  s.name          = 'ctf-party'
  s.version       = Version::VERSION
  s.platform      = Gem::Platform::RUBY
  s.date          = '2019-11-19'
  s.summary       = 'A library to enhance and speed up script/exploit writting'\
                    ' for CTF players'
  s.description   = 'A library to enhance and speed up script/exploit writting'\
                    'for CTF players (or security researchers, bug bounty'\
                    'hunters, pentesters but mostly focused on CTF) by'\
                    'patching the String class to add a short syntax of usual'\
                    ' code patterns.'
  s.authors       = ['Alexandre ZANNI']
  s.email         = 'alexandre.zanni@engineer.com'
  s.homepage      = 'https://orange-cyberdefense.github.io/ctf-party/'
  s.license       = 'MIT'

  s.files         = Dir['docs/**/*'] + Dir['lib/**/*.rb'] + Dir['test/*.rb']
  s.files         += Dir['bin/*'] + ['docs/.nojekyll', 'Rakefile']
  s.files         += ['README.md', 'LICENSE.txt', 'Gemfile.lock', 'Gemfile']
  s.files         += ['.yardopts-dev', '.yardopts', '.rubocop.yml']
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test)/})
  s.require_paths = ['lib']

  s.metadata = {
    'yard.run'          => 'yard',
    'bug_tracker_uri'   => 'https://github.com/Orange-Cyberdefense/ctf-party/issues',
    'changelog_uri'     => 'https://github.com/Orange-Cyberdefense/ctf-party/blob/master/docs/CHANGELOG.md',
    'documentation_uri' => 'https://orange-cyberdefense.github.io/ctf-party/',
    'homepage_uri'      => 'https://orange-cyberdefense.github.io/ctf-party/',
    'source_code_uri'   => 'https://github.com/Orange-Cyberdefense/ctf-party/'
  }

  s.required_ruby_version = '~> 2.4'

  s.add_development_dependency('bundler', '~> 2.0')
  s.add_development_dependency('commonmarker', '~> 0.20') # for GMF support in YARD
  s.add_development_dependency('github-markup', '~> 3.0') # for GMF support in YARD
  s.add_development_dependency('minitest', '~> 5.11')
  s.add_development_dependency('rake', '~> 12.3')
  s.add_development_dependency('redcarpet', '~> 3.4') # for GMF support in YARD
  s.add_development_dependency('rubocop', '~> 0.63')
  s.add_development_dependency('yard', '~> 0.9')
end
