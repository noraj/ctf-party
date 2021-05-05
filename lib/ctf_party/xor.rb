# frozen_string_literal: true

class String
  # UTF-8 XOR with key, padding left the shortest element
  # @param key [String] the element to xor the string with
  # @return [String] the xored string (UTF-8)
  # @example
  #   'hello'.ulxor('key') # => "he\a\t\u0016"
  #   'key'.ulxor('hello') # => "he\a\t\u0016"
  def ulxor(key)
    b1 = unpack('U*')
    b2 = key.unpack('U*')
    longest = [b1.length, b2.length].max
    b1 = [0] * (longest - b1.length) + b1
    b2 = [0] * (longest - b2.length) + b2
    b1.zip(b2).map { |a, b| a ^ b }.pack('U*')
  end

  # UTF-8 XOR with key (padding left) in place as described for {String#ulxor}.
  def ulxor!(key)
    replace(ulxor(key))
  end

  # ASCII XOR with key, padding left the shortest element
  # @param key [String] the element to xor the string with
  # @return [String] the xored string (ASCII)
  # @example
  #   'hello'.alxor('key') # => "he\a\t\x16"
  #   'key'.alxor('hello') # => "he\a\t\x16"
  def alxor(key)
    b1 = force_encoding('UTF-8')
    b2 = key.force_encoding('UTF-8')
    raise 'The string is not ASCII' unless b1.ascii_only?
    raise 'The key is not ASCII' unless b2.ascii_only?

    b1 = b1.chars.map(&:ord)
    b2 = b2.chars.map(&:ord)
    longest = [b1.length, b2.length].max
    b1 = [0] * (longest - b1.length) + b1
    b2 = [0] * (longest - b2.length) + b2
    b1.zip(b2).map { |a, b| (a ^ b).chr }.join
  end

  # ASCII XOR with key (padding left) in place as described for {String#alxor}.
  def alxor!(key)
    replace(alxor(key))
  end

  # UTF-8 XOR with key, padding right the shortest element
  # @param key [String] the element to xor the string with
  # @return [String] the xored string (UTF-8)
  # @example
  #   'hello'.urxor('key') # => "\u0003\u0000\u0015lo"
  #   'key'.urxor('hello') # => "\u0003\u0000\u0015lo"
  def urxor(key)
    b1 = unpack('U*')
    b2 = key.unpack('U*')
    longest = [b1.length, b2.length].max
    b1 += [0] * (longest - b1.length)
    b2 += [0] * (longest - b2.length)
    b1.zip(b2).map { |a, b| a ^ b }.pack('U*')
  end

  # UTF-8 XOR with key (padding right) in place as described for {String#urxor}.
  def urxor!(key)
    replace(urxor(key))
  end

  # ASCII XOR with key, padding right the shortest element
  # @param key [String] the element to xor the string with
  # @return [String] the xored string (ASCII)
  # @example
  #   'hello'.arxor('key') # => "\x03\x00\x15lo"
  #   'key'.arxor('hello') # => "\x03\x00\x15lo"
  def arxor(key)
    b1 = force_encoding('UTF-8')
    b2 = key.force_encoding('UTF-8')
    raise 'The string is not ASCII' unless b1.ascii_only?
    raise 'The key is not ASCII' unless b2.ascii_only?

    b1 = b1.chars.map(&:ord)
    b2 = b2.chars.map(&:ord)
    longest = [b1.length, b2.length].max
    b1 += [0] * (longest - b1.length)
    b2 += [0] * (longest - b2.length)
    b1.zip(b2).map { |a, b| (a ^ b).chr }.join
  end

  # ASCII XOR with key (padding right) in place as described for {String#arxor}.
  def arxor!(key)
    replace(arxor(key))
  end
end
