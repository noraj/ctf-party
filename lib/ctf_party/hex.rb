# frozen_string_literal: true

class String
  # Encode an hexadecimal string to a decimal string
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the input. Default value is a void
  #   string. Example of values: +0x+, +\x+.
  # @return [String] the decimal encoded string
  # @example
  #   'ff'.hex2dec # => "255"
  #   '\xf3'.hex2dec(prefix: '\x') # => "243"
  def hex2dec(opts = {})
    opts[:prefix] ||= ''
    # remove prefix
    out = sub(opts[:prefix], '')
    # convert
    return out.hex.to_s
  end

  # Encode an hexadecimal string to a decimal string in place as described
  # for {String#hex2dec}.
  # @example
  #   a = 'ff'
  #   a.hex2dec!
  #   a # => "255"
  def hex2dec!(opts = {})
    replace(hex2dec(opts))
  end

  # Encode an decimal string to a hexadecimal string
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the output. Default value is a void
  #   string. Example of values: +0x+, +\x+.
  # @option opts [Symbol] :case Char case of the ouput. Default value +:lower+.
  #   Other valid value +:upper+.
  # @return [String] the hexadecimal encoded string
  # @example
  #   '255'.dec2hex # => "ff"
  #   '255'.dec2hex({prefix: '0x', case: :upper}) # => "0xFF"
  def dec2hex(opts = {})
    opts[:prefix] ||= ''
    opts[:case] ||= :lower
    # convert
    out = to_i.to_s(16)
    # char case management
    out = out.upcase if opts[:case] == :upper
    # adding prefix must be done after case change
    return opts[:prefix] + out
  end

  # Encode an decimal string to a hexadecimal string in place as described
  # for {String#dec2hex}.
  # @example
  #   a = '255'
  #   a.dec2hex!
  #   a # => "ff"
  def dec2hex!(opts = {})
    replace(dec2hex(opts))
  end

  # Encode a string into hexadecimal
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the output. Default value is a void
  #   string. Example of values: +0x+, +\x+.
  # @option opts [Symbol] :case Char case of the ouput. Default value +:lower+.
  #   Other valid value +:upper+.
  # @option opts [Symbol] :nibble Display output with high nibble first
  #   (+:high+ default) or low nibble first (+:low+).
  # @return [String] the hexadecimal encoded string
  # @example
  #   'noraj'.to_hex # => "6e6f72616a"
  #   'noraj'.to_hex(prefix: '0x') # => "0x6e6f72616a"
  #   'noraj'.to_hex(case: :upper) # => "6E6F72616A"
  #   'noraj'.to_hex(nibble: :low) # => "e6f62716a6"
  def to_hex(opts = {})
    opts[:prefix] ||= ''
    opts[:case] ||= :lower
    opts[:nibble] ||= :high
    # convert
    out = ''
    case opts[:nibble]
    when :high
      out = unpack1('H*')
    when :low
      out = unpack1('h*')
    end
    # char case management
    out = out.upcase if opts[:case] == :upper
    # adding prefix must be done after case change
    return opts[:prefix] + out
  end

  # Encode a string into hexadecimal in place as described
  # for {String#to_hex}.
  # @example
  #   a = 'noraj'
  #   a.to_hex!
  #   a # => "6e6f72616a"
  def to_hex!(opts = {})
    replace(to_hex(opts))
  end

  # Decode a hexadecimal string
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the input. Default value is a void
  #   string. Example of values: +0x+, +\x+.
  # @option opts [Symbol] :nibble Display input with high nibble first
  #   (+:high+ default) or low nibble first (+:low+).
  # @return [String] the hexadecimal decoded string
  # @example
  #   "6e6f72616a".from_hex # => "noraj"
  #   "0x6e6f72616a".from_hex(prefix: '0x') # => "noraj"
  #   "e6f62716a6".from_hex(nibble: :low) # => "noraj"
  def from_hex(opts = {})
    opts[:prefix] ||= ''
    opts[:nibble] ||= :high
    # remove prefix
    out = sub(opts[:prefix], '')
    # convert
    return Array(out).pack('H*') if opts[:nibble] == :high
    return Array(out).pack('h*') if opts[:nibble] == :low

    raise ArgumentError ':nibble expects :high or :low'
  end

  # Decode a hexadecimal string in place as described
  # for {String#from_hex}.
  # @example
  #   a = "6e6f72616a"
  #   a.from_hex!
  #   a # => "noraj"
  def from_hex!(opts = {})
    replace(from_hex(opts))
  end

  # Encode an hexadecimal string to a binary string
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the input. Default value is a void
  #   string. Example of values: +0x+, +\x+.
  # @return [String] the binary encoded string
  # @example
  #   'ab'.hex2bin # => "10101011"
  #   '\xf3'.hex2bin(prefix: '\x') # => "11110011"
  def hex2bin(opts = {})
    opts[:prefix] ||= ''
    # remove prefix
    out = sub(opts[:prefix], '')
    # convert
    return out.to_i(16).to_s(2)
  end

  # Encode an hexadecimal string to a binary string in place as described
  # for {String#hex2bin}.
  # @example
  #   a = 'ff'
  #   a.hex2bin!
  #   a # => => "11111111"
  def hex2bin!(opts = {})
    replace(hex2bin(opts))
  end

  # Encode an binary string to a hexadecimal string
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the output. Default value is a void
  #   string. Example of values: +0x+, +\x+.
  # @option opts [Symbol] :case Char case of the ouput. Default value +:lower+.
  #   Other valid value +:upper+.
  # @return [String] the hexadecimal encoded string
  # @example
  #   '11110011'.bin2hex # => "f3"
  #   '11110011'.bin2hex({prefix: '0x', case: :upper}) # => "0xF3"
  def bin2hex(opts = {})
    opts[:prefix] ||= ''
    opts[:case] ||= :lower
    # convert
    out = to_i(2).to_s(16)
    # char case management
    out = out.upcase if opts[:case] == :upper
    # adding prefix must be done after case change
    return opts[:prefix] + out
  end

  # Encode an binary string to a hexadecimal string in place as described
  # for {String#bin2hex}.
  # @example
  #   a = '11110011'
  #   a.bin2hex!
  #   a # => "f3"
  def bin2hex!(opts = {})
    replace(bin2hex(opts))
  end
end
