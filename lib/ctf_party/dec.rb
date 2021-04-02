# frozen_string_literal: true

class String
  # Encode a string into decimal (string to hexadecimal then hexadecimal to decimal)
  # @return [String] the decimal encoded string
  # @example
  #   'noraj'.to_dec # => "474316169578"
  def to_dec
    str2hex.hex2dec
  end

  # Encode a string into decimal in place as described for {String#to_dec}.
  def to_dec!
    replace(to_dec)
  end

  # Decode a decimal string (decimal to hexadecimal then hexadecimal to string)
  # @return [String] the decimal decoded string
  # @example
  #   '1834615104613964215417'.from_dec # => "ctf-party"
  def from_dec
    dec2hex.hex2str
  end

  # Decode a decimal string in place as described for {String#from_dec}.
  def from_dec!
    replace(from_dec)
  end

  # Alias for {String#to_dec}.
  def str2dec
    to_dec
  end

  # Alias for {String#to_dec!}.
  def str2dec!
    replace(str2dec)
  end

  # Alias for {String#from_dec}.
  def dec2str
    from_dec
  end

  # Alias for {String#from_dec!}.
  def dec2str!
    replace(dec2str)
  end
end
