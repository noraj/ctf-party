# frozen_string_literal: true

# Ruby standard library
require 'digest'

class String
  # Calculate the md5 hash of the string.
  # @see https://ruby-doc.org/stdlib-2.6.1/libdoc/digest/rdoc/Digest/MD5.html
  # @return [String] md5 hash
  # @example
  #   'noraj'.md5 # => "556cc23863fef20fab5c456db166bc6e"
  def md5
    Digest::MD5.hexdigest self
  end

  # Calculate the md5 hash of the string in place as described for {String#md5}.
  # @example
  #   a = '\o/' # => "\\o/"
  #   a.md5! # => "881419964e480e66162da521ccc25ebf"
  #   a # => "881419964e480e66162da521ccc25ebf"
  def md5!
    replace(md5)
  end

  # Calculate the sha1 hash of the string.
  # @see https://ruby-doc.org/stdlib-2.6.1/libdoc/digest/rdoc/Digest/SHA1.html
  # @return [String] sha1 hash
  # @example
  #   'ctf-party'.sha1 # => "5a64f3bc491d0977e1e3578a48c65a89a16a5fe8"
  def sha1
    Digest::SHA1.hexdigest self
  end

  # Calculate the sha1 hash of the string in place as described for
  #   {String#sha1}.
  # @example
  #   bob = 'alice' # => "alice"
  #   bob.sha1! # => "522b276a356bdf39013dfabea2cd43e141ecc9e8"
  #   bob # => "522b276a356bdf39013dfabea2cd43e141ecc9e8"
  def sha1!
    replace(sha1)
  end

  # Calculate the sha2 hash of the string.
  # @param opts [Hash] optional parameters
  # @option opts [Integer] :bitlen Defines the bit lenght of the digest.
  #   Default value: 256 (SHA2-256). other valid vales are 384 (SHA2-384)
  #   and 512 (SHA2-512).
  # @see https://ruby-doc.org/stdlib-2.6.1/libdoc/digest/rdoc/Digest/SHA2.html
  # @return [String] sha hash
  # @example
  #   'try harder'.sha2 # => "5321ff2d4b1389b3a350dfe8ca77e3889dc6259bb233ad..."
  #   'try harder'.sha2(bitlen: 512) # => "a7b73a98c095b22e25407b15c4dec128c..."
  def sha2(opts = {})
    opts[:bitlen] ||= 256
    Digest::SHA2.new(opts[:bitlen]).hexdigest self
  end

  # Calculate the sha2 hash of the string in place as described for
  #   {String#sha2}.
  # @example
  #   th = 'try harder' # => "try harder"
  #   th.sha2!(bitlen: 384) # => "bb7f60b9562a19c3a83c23791440af11591c42ede9..."
  #   th # => "bb7f60b9562a19c3a83c23791440af11591c42ede9988334cdfd7efa4261a..."
  def sha2!(opts = {})
    replace(sha2(opts))
  end

  # Alias for {String#sha2} with default value ( `sha2(bitlen: 256)` ).
  def sha2_256
    sha2
  end

  # Alias for {String#sha2!} with default value ( `sha2!(bitlen: 256)` ).
  def sha2_256!
    replace(sha2)
  end

  # Alias for {String#sha2} with default value ( `sha2(bitlen: 384)` ).
  def sha2_384
    sha2(bitlen: 384)
  end

  # Alias for {String#sha2!} with default value ( `sha2!(bitlen: 384)` ).
  def sha2_384!
    replace(sha2(bitlen: 384))
  end

  # Alias for {String#sha2} with default value ( `sha2(bitlen: 512)` ).
  def sha2_512
    sha2(bitlen: 512)
  end

  # Alias for {String#sha2!} with default value ( `sha2!(bitlen: 512)` ).
  def sha2_512!
    replace(sha2(bitlen: 512))
  end

  # Calculate the RIPEMD-160 hash of the string.
  # @see https://ruby-doc.org/stdlib-2.6.1/libdoc/digest/rdoc/Digest/RMD160.html
  # @return [String] RIPEMD-160 hash
  # @example
  #   'payload'.rmd160 # => "3c6255c112d409dafdb84d5b0edba98dfd27b44f"
  def rmd160
    Digest::RMD160.hexdigest self
  end

  # Calculate the RIPEMD-160 hash of the string in place as described for
  # {String#rmd160}.
  # @example
  #   pl = 'payload' # => "payload"
  #   pl.rmd160! # => "3c6255c112d409dafdb84d5b0edba98dfd27b44f"
  #   pl # => "3c6255c112d409dafdb84d5b0edba98dfd27b44f"
  def rmd160!
    replace(rmd160)
  end
end
