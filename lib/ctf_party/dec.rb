# frozen_string_literal: true

class String
  # Encode a string into decimal (string to hexadecimal then hexadecimal to decimal)
  # @param opts [Hash] optional parameters (see {String#to_hex} and {String#hex2dec})
  # @return [String] the decimal encoded string
  # @example
  #   'noraj'.to_dec # => "474316169578"
  def to_dec(opts = {})
    to_hex(opts).hex2dec(opts)
  end

  # Encode a string into decimal in place as described for {String#to_dec}.
  def to_dec!(opts = {})
    replace(to_dec(opts))
  end

  # Decode a decimal string (decimal to hexadecimal then hexadecimal to string)
  # @param opts [Hash] optional parameters (see {String#dec2hex} and {String#from_hex})
  # @return [String] the decimal decoded string
  # @example
  #   '1834615104613964215417'.from_dec # => "ctf-party"
  def from_dec(opts = {})
    dec2hex(opts).from_hex(opts)
  end

  # Decode a decimal string in place as described for {String#from_dec}.
  def from_dec!(opts = {})
    replace(from_dec(opts))
  end

  # Alias for {String#to_dec}.
  def str2dec(opts = {})
    to_dec(opts)
  end

  # Alias for {String#to_dec!}.
  def str2dec!(opts = {})
    replace(str2dec(opts))
  end

  # Alias for {String#from_dec}.
  def dec2str(opts = {})
    from_dec(opts)
  end

  # Alias for {String#from_dec!}.
  def dec2str!(opts = {})
    replace(dec2str(opts))
  end
end
