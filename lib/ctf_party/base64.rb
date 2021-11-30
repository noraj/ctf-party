# frozen_string_literal: true

# Ruby standard library
require 'base64'

class String
  # Encode the string into base64
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :mode Default value: `:strict`.
  #   Other values are `:strict` (`:rfc4648`) or `:urlsafe`.
  # @see https://ruby-doc.org/stdlib-2.6.5/libdoc/base64/rdoc/Base64.html
  # @return [String] the Base64 encoded string
  # @example
  #   'Super lib!'.to_b64 # => "U3VwZXIgbGliIQ=="
  def to_b64(opts = {})
    opts[:mode] ||= :strict
    return Base64.strict_encode64(self) if opts[:mode] == :strict ||
                                           opts[:mode] == :rfc4648
    return Base64.encode64(self) if opts[:mode] == :rfc2045
    return Base64.urlsafe_encode64(self) if opts[:mode] == :urlsafe
  end

  # Encode the string into base64 in place as described for {String#to_b64}.
  # @return [nil]
  # @example
  #   myStr = 'Ruby' # => "Ruby"
  #   myStr.to_b64! # => nil
  #   myStr # => "UnVieQ=="
  def to_b64!(opts = {})
    replace(to_b64(opts))
  end

  # Decode the string from base64
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :mode Default value: `:strict`.
  #   Other values are `:strict` (`:rfc4648`) or `:urlsafe`.
  # @see https://ruby-doc.org/stdlib-2.6.5/libdoc/base64/rdoc/Base64.html
  # @return [String] the Base64 decoded string
  # @example
  #   'UnVieQ=='.from_b64 # => "Ruby"
  def from_b64(opts = {})
    opts[:mode] ||= :strict
    return Base64.strict_decode64(self) if opts[:mode] == :strict ||
                                           opts[:mode] == :rfc4648
    return Base64.decode64(self) if opts[:mode] == :rfc2045
    return Base64.urlsafe_decode64(self) if opts[:mode] == :urlsafe
  end

  # Decode the string from base64 in place as described for {String#from_b64}.
  # @return [nil]
  # @example
  #   a = 'SGVsbG8gd29ybGQh' # => "SGVsbG8gd29ybGQh"
  #   a.from_b64! # => nil
  #   a # => "Hello world!"
  def from_b64!(opts = {})
    replace(from_b64(opts))
  end

  # Is the string encoded in base64?
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :mode Default value: `:strict`.
  #   Other values are `:strict` (`:rfc4648`) or `:urlsafe`.
  # @see https://ruby-doc.org/stdlib-2.6.5/libdoc/base64/rdoc/Base64.html
  # @return [Boolean] `true` if the string is a valid base64 string, `false`
  #   else.
  # @example
  #   'SGVsbG8gd29ybGQh'.b64? # => true
  #   'SGVsbG8g@@d29ybGQh'.b64? # => false
  def b64?(opts = {})
    opts[:mode] ||= :strict
    b64 = false
    # https://www.rexegg.com/regex-ruby.html
    reg1 = %r{\A(?:[a-zA-Z0-9+/]{4})*(?:|(?:[a-zA-Z0-9+/]{3}=)|
              (?:[a-zA-Z0-9+/]{2}==)|(?:[a-zA-Z0-9+/]{1}===))\Z}xn
    reg3 = /\A(?:[a-zA-Z0-9\-_]{4})*(?:|(?:[a-zA-Z0-9\-_]{3}=)|
            (?:[a-zA-Z0-9\-_]{2}==)|(?:[a-zA-Z0-9\-_]{1}===))\Z/xn
    case opts[:mode]
    when :strict, :rfc4648
      b64 = true if reg1.match?(self)
    when :rfc2045
      b64 = true
      split("\n").each do |s|
        b64 = false unless reg1.match?(s)
      end
    when :urlsafe
      b64 = true if reg3.match?(self)
    else
      raise ArgumentError 'Wrong mode'
    end
    return b64
  end
end
