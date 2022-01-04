# frozen_string_literal: true

class String
  # Encode an hexadecimal string to a decimal string
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the input. Default value is a void
  #   string. Example of values: `0x`, `\x`, `\\x`.
  # @return [String] the decimal encoded string
  # @example
  #   'ff'.hex2dec # => "255"
  #   '\xf3'.hex2dec(prefix: '\x') # => "243"
  #   '6e6f72616a'.hex2dec # => "474316169578"
  #   '\\x6e\\x6f\\x72\\x61\\x6a'.hex2dec(prefix: '\\x') # => "474316169578"
  def hex2dec(opts = {})
    opts[:prefix] ||= ''
    # remove prefix
    out = gsub(opts[:prefix], '')
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
  #   string. Example of values: `0x`, `\x`.
  # @option opts [String] :prefixall Prefix each byte. Default value is a void
  #   string. Example of value: `\\x`.
  # @option opts [Symbol] :case Char case of the output. Default value `:lower`.
  #   Other valid value `:upper`.
  # @option opts [Symbol] :padding Minimum size of the hexadecimal display
  #   (number of characters). Must be even.
  # @return [String] the hexadecimal encoded string
  # @example
  #   '255'.dec2hex # => "ff"
  #   '255'.dec2hex({prefix: '0x', case: :upper}) # => "0xFF"
  #   '10'.dec2hex(padding: 2) # => "0a"
  #   '10'.dec2hex(padding: 8) # => "0000000a"
  #   '474316169578'.dec2hex(prefixall: '\\x') # => "\\x6e\\x6f\\x72\\x61\\x6a"
  def dec2hex(opts = {})
    opts[:prefix] ||= ''
    opts[:prefixall] ||= ''
    opts[:case] ||= :lower
    opts[:padding] ||= 2
    raise(ArgumentError, 'Padding must be even') if opts[:padding].odd?

    # convert
    out = to_i.to_s(16)
    # padding
    out = ('0' * (opts[:padding] - out.size)) + out if out.size < opts[:padding]
    # char case management
    out = out.upcase if opts[:case] == :upper
    # adding prefix must be done after case change
    out = out.scan(/.{2}/).map { |x| opts[:prefixall] + x }.join
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
  #   string. Example of values: `0x`, `\x`.
  # @option opts [String] :prefixall Prefix each byte. Default value is a void
  #   string. Example of value: `\\x`.
  # @option opts [Symbol] :case Char case of the output. Default value `:lower`.
  #   Other valid value `:upper`.
  # @option opts [Symbol] :nibble Display output with high nibble first
  #   (`:high` default) or low nibble first (`:low`).
  # @return [String] the hexadecimal encoded string
  # @example
  #   'noraj'.to_hex # => "6e6f72616a"
  #   'noraj'.to_hex(prefix: '0x') # => "0x6e6f72616a"
  #   'noraj'.to_hex(case: :upper) # => "6E6F72616A"
  #   'noraj'.to_hex(nibble: :low) # => "e6f62716a6"
  #   'noraj'.to_hex(prefixall: '\\x') # => "\\x6e\\x6f\\x72\\x61\\x6a"
  def to_hex(opts = {})
    opts[:prefix] ||= ''
    opts[:prefixall] ||= ''
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
    out = out.scan(/.{2}/).map { |x| opts[:prefixall] + x }.join
    return opts[:prefix] + out
  end

  # Alias for {String#to_hex}.
  def str2hex(opts = {})
    to_hex(opts)
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

  # Alias for {String#to_hex!}.
  def str2hex!(opts = {})
    to_hex!(opts)
  end

  # Decode a hexadecimal string
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the input. Default value is a void
  #   string. Example of values: `0x`, `\x`, `\\x`.
  # @option opts [Symbol] :nibble Display input with high nibble first
  #   (`:high` default) or low nibble first (`:low`).
  # @return [String] the hexadecimal decoded string
  # @example
  #   "6e6f72616a".from_hex # => "noraj"
  #   "0x6e6f72616a".from_hex(prefix: '0x') # => "noraj"
  #   "e6f62716a6".from_hex(nibble: :low) # => "noraj"
  #   '\\x6e\\x6f\\x72\\x61\\x6a'.from_hex(prefix: '\\x') # => "noraj"
  def from_hex(opts = {})
    opts[:prefix] ||= ''
    opts[:nibble] ||= :high
    # remove prefix
    out = gsub(opts[:prefix], '')
    # convert
    return Array(out).pack('H*') if opts[:nibble] == :high
    return Array(out).pack('h*') if opts[:nibble] == :low

    raise ArgumentError ':nibble expects :high or :low'
  end

  # Alias for {String#from_hex}.
  def hex2str(opts = {})
    from_hex(opts)
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

  # Alias for {String#from_hex!}.
  def hex2str!(opts = {})
    from_hex!(opts)
  end

  # Encode an hexadecimal string to a binary string
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the input. Default value is a void
  #   string. Example of values: `0x`, `\x`, `\\x`.
  # @return [String] the binary encoded string
  # @example
  #   'ab'.hex2bin # => "10101011"
  #   '\xf3'.hex2bin(prefix: '\x') # => "11110011"
  #   '\\x6e\\x6f\\x72\\x61\\x6a'.hex2bin(prefix: '\\x') # => "110111001101111011100100110000101101010"
  def hex2bin(opts = {})
    opts[:prefix] ||= ''
    # remove prefix
    out = gsub(opts[:prefix], '')
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
  #   string. Example of values: `0x`, `\x`.
  # @option opts [String] :prefixall Prefix each byte. Default value is a void
  #   string. Example of value: `\\x`.
  # @option opts [Symbol] :case Char case of the output. Default value `:lower`.
  #   Other valid value `:upper`.
  # @return [String] the hexadecimal encoded string
  # @example
  #   '11110011'.bin2hex # => "f3"
  #   '11110011'.bin2hex({prefix: '0x', case: :upper}) # => "0xF3"
  #   '0110111001101111011100100110000101101010'.bin2hex(prefixall: '\\x') # => "\\x6e\\x6f\\x72\\x61\\x6a"
  def bin2hex(opts = {})
    opts[:prefix] ||= ''
    opts[:prefixall] ||= ''
    opts[:case] ||= :lower
    # convert
    out = to_i(2).to_s(16)
    # char case management
    out = out.upcase if opts[:case] == :upper
    # adding prefix must be done after case change
    out = out.scan(/.{2}/).map { |x| opts[:prefixall] + x }.join
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

  # Decode a hexadecimal IP string into a dotted decimal one
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the input. Default value is a void
  #   string. Example of values: `0x`, `\x`, '\\x'.
  # @option opts [Symbol] :nibble Display input with high nibble first
  #   (`:high` default) or low nibble first (`:low`, used on Unix `/proc/net/tcp`).
  # @return [String] the dotted decimal IP
  # @example
  #   '0100007F'.from_hexip(nibble: :low) # => "127.0.0.1"
  #   '0x7f000001'.from_hexip(prefix: '0x') # => "127.0.0.1"
  #   '\\x7f\\x00\\x00\\x01'.from_hexip(prefix: '\\x') # => "127.0.0.1"
  def from_hexip(opts = {})
    opts[:prefix] ||= ''
    opts[:nibble] ||= :high
    # remove prefix
    out = gsub(opts[:prefix], '')
    # convert
    out = out.scan(/.{2}/).map(&:hex2dec)
    out = out.reverse if opts[:nibble] == :low
    out.join('.')
  end

  # Decode a hexadecimal IP string into a dotted decimal one in place as described
  # for {String#from_hexip}.
  def from_hexip!(opts = {})
    replace(from_hexip(opts))
  end

  # Encode a dotted decimal IP into a hexadecimal one
  # @param opts [Hash] optional parameters
  # @option opts [String] :prefix Prefix of the output. Default value is a void
  #   string. Example of values: `0x`, `\x`.
  # @option opts [String] :prefixall Prefix each byte. Default value is a void
  #   string. Example of value: `\\x`.
  # @option opts [Symbol] :case Char case of the output. Default value `:lower`.
  #   Other valid value `:upper`.
  # @option opts [Symbol] :nibble Display output with high nibble first
  #   (`:high` default) or low nibble first (`:low`, used on Unix `/proc/net/tcp`).
  # @return [String] the hexadecimal encoded IP
  # @example
  #   '127.0.0.1'.to_hexip # => "7f000001"
  #   '127.0.0.1'.to_hexip(nibble: :low) # => "0100007f"
  #   '127.0.0.1'.to_hexip(prefixall: '\\x') # => "\\x7f\\x00\\x00\\x01"
  def to_hexip(opts = {})
    opts[:prefix] ||= ''
    opts[:prefixall] ||= ''
    opts[:case] ||= :lower
    opts[:nibble] ||= :high
    # convert
    out = split('.').map { |x| x.dec2hex(padding: 2) }
    out = out.reverse if opts[:nibble] == :low
    out = out.join
    # char case management
    out = out.upcase if opts[:case] == :upper
    # adding prefix must be done after case change
    out = out.scan(/.{2}/).map { |x| opts[:prefixall] + x }.join
    return opts[:prefix] + out
  end

  # Encode a dotted decimal IP into a hexadecimal one in place as described
  # for {String#to_hexip}.
  def to_hexip!(opts = {})
    replace(to_hexip(opts))
  end
end
