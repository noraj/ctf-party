# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :runtime, :cli do
  gem 'docopt', '~> 0.6' # for argument parsing
end

group :runtime, :all do
  gem 'base64', '~> 0.3.0' # for base64 encoding
  gem 'cgi', '~> 0.4' # url decode / html escape
  gem 'uri', '~> 1.1' # for url parsing
end

group :development, :install do
  gem 'bundler', '~> 4.0'
end

group :development, :test do
  gem 'minitest', '~> 6.0'
  gem 'minitest-skip', '~> 1.0'
  gem 'rake', '~> 13.4'
end

group :development, :lint do
  gem 'rubocop', '~> 1.86'
end

group :development, :docs do
  gem 'commonmarker', '~> 2.8' # for markdown support in YARD
  gem 'yard', ['>= 0.9.43', '< 0.10']
end
