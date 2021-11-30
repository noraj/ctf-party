# frozen_string_literal: true

require 'ctf_party/digest'

class String
  # The flag configuration hash. See {.flag=}.
  @@flag = {
    prefix: '',
    suffix: '',
    enclosing: ['{', '}'],
    digest: nil
  }

  # Show the actual flag configuration. See {.flag=}.
  def self.flag
    @@flag
  end

  # Update the flag configuration.
  # @param hash [Hash] flag configuration
  # @option hash [String] :prefix prefix of the flag. Default: none.
  # @option hash [String] :suffix suffix of the flag. Default: none.
  # @option hash [Array<String>] :enclosing the characters used to surround
  #   the flag. Default are curly braces: `{`, `}`. The array must contain
  #   exactly 2 elements.
  # @option hash [String] :digest the hash algorithm to apply on the flag.
  #   Default: none. Allowed values: md5, sha1, sha2_256, sha2_384, sha2_512,
  #   rmd160.
  # @return [Hash] hash of the updated options.
  # @note You can provide the full hash or only the key to update.
  # @example
  #   String.flag # => {:prefix=>"", :suffix=>"", :enclosing=>["{", "}"], :digest=>nil}
  #   String.flag = {prefix: 'sigsegv', digest: 'md5'}
  #   String.flag # => {:prefix=>"sigsegv", :suffix=>"", :enclosing=>["{", "}"], :digest=>"md5"}
  #   'this_1s_a_fl4g'.flag # => "sigsegv{a5bec9e2a86b6b70d288451eb38dfec8}"
  def self.flag=(hash)
    hash.select! { |k, _v| @@flag.key?(k) }
    @@flag.merge!(hash)
  end

  # Format the current string into the configured flag format. See {.flag=}
  # example.
  # @return [String] the format flag.
  def flag
    flag = ''
    flag += @@flag[:prefix]
    flag += @@flag[:enclosing][0]
    if @@flag[:digest].nil?
      flag += self
    else
      case @@flag[:digest]
      when 'md5'
        flag += md5
      when 'sha1'
        flag += sha1
      when 'sha2_256'
        flag += sha2_256
      when 'sha2_384'
        flag += sha2_384
      when 'sha2_512'
        flag += sha2_512
      when 'rmd160'
        flag += rmd160
      end
    end
    flag += @@flag[:enclosing][1]
    flag + @@flag[:suffix]
  end

  # Format the current string into the configured flag format in place as
  # described for {String#flag}.
  def flag!
    replace(flag)
  end

  # Check if the string respect the defined flag format.
  # @return [Boolean] true if it respects the configured flag format. but it
  #   does not check digest used.
  # @example
  #   String.flag = {prefix: 'flag'}
  #   flag = 'Brav0!'
  #   flag.flag! # => "flag{Brav0!}"
  #   flag.flag? # => true
  #   flag = 'ctf{Brav0!}'
  #   flag.flag? # => false
  def flag?
    /#{@@flag[:prefix]}#{@@flag[:enclosing][0]}[[:print:]]+
      #{@@flag[:enclosing][1]}#{@@flag[:suffix]}/ox.match?(self)
  end
end
