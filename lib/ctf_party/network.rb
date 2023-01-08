# frozen_string_literal: true

require 'ipaddr'
require 'uri'

class String
  def ipv4?
    IPAddr.new(self).ipv4?
  rescue IPAddr::InvalidAddressError
    false
  end

  def ipv6?
    IPAddr.new(self).ipv6?
  rescue IPAddr::InvalidAddressError
    false
  end

  def ip?
    ipv4? || ipv6?
  end

  def uri?
    URI::DEFAULT_PARSER.make_regexp(%w[ftp http https ldap ldaps mailto ws wss]).match?(self)
  end

  # quiet lax
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

  # https://stackoverflow.com/questions/22993545/ruby-email-validation-with-regex/75050279#75050279
  def email?(opts = {})
    opts[:mode] ||= :rfc5322
    case opts[:mode]
    when :strict, :rfc4648
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
