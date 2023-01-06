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
end
