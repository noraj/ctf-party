# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_hex_hex2dec
    assert_equal('255', 'ff'.hex2dec)
    assert_equal('243', '\xf3'.hex2dec(prefix: '\x'))
    assert_equal('474316169578', '6e6f72616a'.hex2dec)
    assert_equal('474316169578', '\\x6e\\x6f\\x72\\x61\\x6a'.hex2dec(prefix: '\\x'))
  end

  skip def test_hex_hex2dec!
    # skip
  end

  def test_hex_dec2hex
    assert_equal('ff', '255'.dec2hex)
    assert_equal('0a', '10'.dec2hex)
    err = assert_raises(ArgumentError) do # odd padding
      '10'.dec2hex(padding: 3)
    end
    assert_equal('Padding must be even', err.message)
    assert_equal('0000000a', '10'.dec2hex(padding: 8))
    assert_equal('0xFF', '255'.dec2hex(prefix: '0x', case: :upper))
    assert_equal('\\x6e\\x6f\\x72\\x61\\x6a', '474316169578'.dec2hex(prefixall: '\\x'))
    # verify no odd byte cropping issue
    assert_equal('1f4a9','128169'.dec2hex)
  end

  skip def test_hex_dec2hex!
    # skip
  end

  def test_hex_to_hex
    assert_equal('6e6f72616a', 'noraj'.to_hex)
    assert_equal('0x6e6f72616a', 'noraj'.to_hex(prefix: '0x'))
    assert_equal('\\x6e\\x6f\\x72\\x61\\x6a', 'noraj'.to_hex(prefixall: '\\x'))
    assert_equal('6E6F72616A', 'noraj'.to_hex(case: :upper))
    assert_equal('e6f62716a6', 'noraj'.to_hex(nibble: :low))
  end

  skip def test_hex_to_hex!
    # skip
  end

  def test_hex_from_hex
    assert_equal('noraj', '6e6f72616a'.from_hex)
    assert_equal('noraj', '0x6e6f72616a'.from_hex(prefix: '0x'))
    assert_equal('noraj', 'e6f62716a6'.from_hex(nibble: :low))
    assert_equal('noraj', '\\x6e\\x6f\\x72\\x61\\x6a'.from_hex(prefix: '\\x'))
  end

  skip def test_hex_from_hex!
    # skip
  end

  def test_hex_hex2bin
    assert_equal('10101011', 'ab'.hex2bin)
    assert_equal('11110011', '\xf3'.hex2bin(prefix: '\x'))
    assert_equal('0110111001101111011100100110000101101010', '\\x6e\\x6f\\x72\\x61\\x6a'.hex2bin(prefix: '\\x'))
  end

  skip def test_hex_hex2bin!
    # skip
  end

  def test_hex_bin2hex
    assert_equal('f3', '11110011'.bin2hex)
    assert_equal('2', '0010'.bin2hex)
    assert_equal('0xF3', '11110011'.bin2hex(prefix: '0x', case: :upper))
    assert_equal('\\x6e\\x6f\\x72\\x61\\x6a', '0110111001101111011100100110000101101010'.bin2hex(prefixall: '\\x'))
  end

  skip def test_hex_bin2hex!
    # skip
  end

  def test_hex_reverse
    assert_equal('noraj', 'noraj'.to_hex.from_hex)
    assert_equal('6e6f72616a', '6e6f72616a'.from_hex.to_hex)
    assert_equal('10', '10'.dec2hex.hex2dec)
    assert_equal('0a', 'a'.hex2dec.dec2hex)
    assert_equal('110111001101111011100100110000101101010', '0110111001101111011100100110000101101010'.bin2hex.hex2bin)
    assert_equal('6e6f72616a', '6e6f72616a'.hex2bin.bin2hex)
    assert_equal('7f000001', '7f000001'.from_hexip.to_hexip)
    assert_equal('127.0.0.1', '127.0.0.1'.to_hexip.from_hexip)
  end

  def test_hex_str2hex
    my_str = 'AAAA'
    assert_equal(my_str.to_hex, my_str.str2hex)
  end

  skip def test_hex_str2hex!
    # skip
  end

  def test_hex_hex2str
    my_str = '41414141'
    assert_equal(my_str.from_hex, my_str.hex2str)
  end

  skip def test_hex_hex2str!
    # skip
  end

  def test_hex_from_hexipv4
    ip = '127.0.0.1'
    assert_equal(ip, '0100007F'.from_hexipv4(nibble: :low))
    assert_equal(ip, '0x7f000001'.from_hexipv4(prefix: '0x'))
    assert_equal(ip, '\\x7f\\x00\\x00\\x01'.from_hexipv4(prefix: '\\x'))
  end

  skip def test_hex_from_hexipv4!
    # skip
  end

  def test_hex_from_hexip
    # skip, alias of from_hexipv4
  end

  skip def test_hex_from_hexip!
    # skip, alias of from_hexipv4!
  end

  def test_hex_to_hexipv4
    ip = '127.0.0.1'
    assert_equal('7f000001', ip.to_hexipv4)
    assert_equal('0100007f', ip.to_hexipv4(nibble: :low))
    assert_equal('\\x7f\\x00\\x00\\x01', ip.to_hexipv4(prefixall: '\\x'))
  end

  skip def test_hex_to_hexipv4!
    # skip
  end

  def test_hex_to_hexip
    # skip, alias of to_hexipv4
  end

  skip def test_hex_to_hexip!
    # skip, alias of to_hexipv4!
  end

  def test_hex_from_hexipv6
    ip = '[fe80::5054:ff:fe1d:adb6]'
    assert_equal(ip, '000080FE00000000FF005450B6AD1DFE'.from_hexipv6)
    assert_equal(ip, '0x000080FE00000000FF005450B6AD1DFE'.from_hexipv6(prefix: '0x'))
    assert_equal('[::]', '00000000000000000000000000000000'.from_hexipv6)
  end

  skip def test_hex_from_hexipv6!
    # skip
  end
end
