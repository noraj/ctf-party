# frozen_string_literal: true

require 'ipaddr'
require 'uri'

class String
  # Is the string an IPv4?
  # @return [Boolean] `true` if the string is a valid IPv4, `false` else.
  # @example
  #   '1.1.1.1'.ipv4? # => true
  #   '127.0.0.300'.ipv4? # => false
  def ipv4?
    IPAddr.new(self).ipv4?
  rescue IPAddr::InvalidAddressError
    false
  end

  # Is the string an IPv6?
  # @return [Boolean] `true` if the string is a valid IPv6, `false` else.
  # @example
  #   '2606:4700:4700::1111'.ipv6? # => true
  #   'fe80::fe80::fe80'.ipv6? # => false
  def ipv6?
    IPAddr.new(self).ipv6?
  rescue IPAddr::InvalidAddressError
    false
  end

  # Is the string an IP address?
  # @return [Boolean] `true` if the string is a valid IP address, `false` else.
  # @example
  #   '127.0.0.1'.ip? # => true
  #   '::1'.ip? # => true
  def ip?
    ipv4? || ipv6?
  end

  # Is the string a valid URI?
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :lax Default value: `false`.
  #   When `lax: false`, only URI matching common protocols (ftp http https ldap ldaps mailto ws wss) are recognized,
  #   but is still a bit lax (eg. `http://` is seen as valid).
  #   When `lax: true`, the parser will accept more types of URI (gopher magnet matrix), but will be very lax and accept
  #   nearly anything including `:`.
  # @return [Boolean] `true` if the string is a valid URI, `false` else.
  # @example
  #   'ftp://ftp.ruby-lang.org/pub/ruby/3.2/ruby-3.2.0.tar.xz'.uri? # => true
  #   'a:'.uri? # => false
  #   'a:'.uri?(lax: true) # => true
  def uri?(opts = {})
    opts[:lax] ||= false
    strict = URI::DEFAULT_PARSER.make_regexp(%w[ftp http https ldap ldaps mailto ws wss]).match?(self)
    lax = URI::DEFAULT_PARSER.make_regexp.match?(self)
    if opts[:lax] == true
      strict || lax
    else
      strict
    end
  end

  # Is the string a valid domain name?
  # It is a bit lax, for exemple it does not validate if the TLD really exist but
  # still performs more check than many checkers.
  # @return [Boolean] `true` if the string is a valid domain name, `false` else.
  # @example
  #   'pwn.by'.domain? # => true
  #   'a.-b.net'.domain? # => false
  # rubocop:disable Metrics/PerceivedComplexity
  def domain?
    return false unless size.between?(1, 255) # max. domain length

    # split each hostname into labels
    labels = split('.')
    return false if labels.size > 127 # max. label number
    return false if labels.size < 2 # min. label number
    return false if labels.first[0] == '.' # cannot start with a dot

    labels.each_with_index do |label, _index|
      return false unless label.size.between?(1, 63) # max. label length
      return false if label[0] == '-' || label[-1] == '-' # label cannot begin or end with hyphen
      # do not set a whitelist for allowed characters ([a-z0-9\-\_]) since there can be
      # Unicode IDN (without punycode transcription)
      # to not deal with punycode translation and validation, let's just do pseudo-validation
      # by checking only for a few illegal ones (blacklist)
      return false if /\p{C}|\p{Z}/.match?(self)
      # skip TLD validity check since the list is large, often change and custom TLD could be used for internal usage
    end
    return false if /\.\./.match?(self) # cannot contain consecutive dots

    # do not check for trailing dot
    true
  end
  # rubocop:enable Metrics/PerceivedComplexity

  # Is the string a valid email address?
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :mode Default value: `:rfc5322`.
  #   Other values are `:strict` (`:rfc5322`), `:light` or `:lightwithlength`.
  #   ``:strict` / `:rfc5322` is the closest thing to RFC 5322.
  #   `:light` is a lighter more practical version of RFC 5322 that will be more useful in real life (omits IP
  #   addresses, domain-specific addresses, the syntax using double quotes and square brackets).
  #   `:lightwithlength` is the same as the light version but with length limit enforcing.
  # @see https://stackoverflow.com/questions/22993545/ruby-email-validation-with-regex/75050279#75050279
  # @return [Boolean] `true` if the string is a valid email address, `false` else.
  # @example
  #   "n#{'o' * 255}raj@pwn.by".email? # => true
  #   "n#{'o' * 255}raj@pwn.by".email?(mode: :lightwithlength) # => false
  #   '"valid"@domain.com'.email?(mode: :rfc5322) # => true
  #   '"valid"@domain.com'.email?(mode: :light) # => false
  def email?(opts = {})
    opts[:mode] ||= :rfc5322
    case opts[:mode]
    when :strict, :rfc5322
      %r{\A(?:[a-z0-9!#$%&'*+/=?^_‘{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_‘{|}~-]+)*|
      "(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|
      \\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|
      \[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|
      [a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|
      \\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])\z}ix.match?(self)
    when :light
      %r{\A[a-z0-9!#$%&'*+/=?^_‘{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_‘{|}~-]+)*@
      (?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z}ix.match?(self)
    when :lightwithlength
      %r{\A(?=[a-z0-9@.!#$%&'*+/=?^_‘{|}~-]{6,254}\z)
      (?=[a-z0-9.!#$%&'*+/=?^_‘{|}~-]{1,64}@)[a-z0-9!#$%&'*+/=?^_‘{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_‘{|}~-]+)*@
      (?:(?=[a-z0-9-]{1,63}\.)[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+
      (?=[a-z0-9-]{1,63}\z)[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z}ix.match?(self)
    end
  end
end
