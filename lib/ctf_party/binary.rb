# frozen_string_literal: true

class String
  # Encode a string into binary
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :bitnumbering Display output with most significant bit
  #   first (+:MSB+ default) or least significant bit first (+:LSB+).
  # @return [String] the binary encoded string
  # @example
  #   'binary'.to_bin # => "011000100110100101101110011000010111001001111001"
  #   'binary'.to_bin(bitnumbering: :LSB) # => "010001101001011001110110100001100100111010011110"
  def to_bin(opts = {})
    opts[:bitnumbering] ||= :MSB
    # convert
    return unpack1('B*') if opts[:bitnumbering] == :MSB
    return unpack1('b*') if opts[:bitnumbering] == :LSB

    raise ArgumentError ':bitnumbering expects :MSB or :LSB'
  end

  # Alias for {String#to_bin}.
  def str2bin(opts = {})
    to_bin(opts)
  end

  # Encode a string into binary in place as described
  # for {String#to_bin}.
  # @example
  #   a = 'binary'
  #   a.to_bin!
  #   a # => "011000100110100101101110011000010111001001111001"
  def to_bin!(opts = {})
    replace(to_bin(opts))
  end

  # Alias for {String#to_bin!}.
  def str2bin!(opts = {})
    to_bin!(opts)
  end

  # Decode a binary string
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :bitnumbering Display input with most significant bit
  #   first (+:MSB+ default) or least significant bit first (+:LSB+).
  # @return [String] the binary decoded string
  # @example
  #   '011000100110100101101110011000010111001001111001'.from_bin # => "binary"
  #   '010001101001011001110110100001100100111010011110'.from_bin(bitnumbering: :LSB) # => "binary"
  def from_bin(opts = {})
    opts[:bitnumbering] ||= :MSB
    # convert
    return Array(self).pack('B*') if opts[:bitnumbering] == :MSB
    return Array(self).pack('b*') if opts[:bitnumbering] == :LSB

    raise ArgumentError ':bitnumbering expects :MSB or :LSB'
  end

  # Alias for {String#from_bin}.
  def bin2str(opts = {})
    from_bin(opts)
  end

  # Decode a binary string in place as described
  # for {String#from_bin}.
  # @example
  #   a = "011000100110100101101110011000010111001001111001"
  #   a.from_bin!
  #   a # => "binary"
  def from_bin!(opts = {})
    replace(from_bin(opts))
  end

  # Alias for {String#from_bin!}.
  def bin2str!(opts = {})
    from_bin!(opts)
  end
end