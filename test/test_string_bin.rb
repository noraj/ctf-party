# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_bin_to_bin
    my_str = 'binary'
    assert_equal('011000100110100101101110011000010111001001111001', my_str.to_bin)
    assert_equal('010001101001011001110110100001100100111010011110', my_str.to_bin(bitnumbering: :LSB))
    assert_equal(my_str.to_bin, my_str.to_bin(bitnumbering: :MSB))
  end

  skip def test_bin_to_bin!
    # skip
  end

  def test_bin_str2bin
    my_str = 'binary'
    assert_equal(my_str.to_bin, my_str.str2bin)
    assert_equal(my_str.to_bin(bitnumbering: :LSB), my_str.str2bin(bitnumbering: :LSB))
  end

  skip def test_bin_str2bin!
    # skip
  end

  def test_bin_from_bin
    my_str = 'binary'
    assert_equal(my_str, '011000100110100101101110011000010111001001111001'.from_bin)
    assert_equal(my_str, '010001101001011001110110100001100100111010011110'.from_bin(bitnumbering: :LSB))
    assert_equal(my_str, '011000100110100101101110011000010111001001111001'.from_bin(bitnumbering: :MSB))
  end

  skip def test_bin_from_bin!
    # skip
  end

  def test_bin_bin2str
    my_str1 = '011000100110100101101110011000010111001001111001'
    my_str2 = '010001101001011001110110100001100100111010011110'
    assert_equal(my_str1.from_bin, my_str1.bin2str)
    assert_equal(my_str2.from_bin(bitnumbering: :LSB), my_str2.bin2str(bitnumbering: :LSB))
  end

  skip def test_bin_bin2str!
    # skip
  end

  def test_bin_bin2dec
    assert_equal('108204962968185', '011000100110100101101110011000010111001001111001'.bin2dec)
  end

  skip def test_bin_bin2dec!
    # skip
  end

  def test_bin_dec2bin
    assert_equal('0110111001101111011100100110000101101010', '474316169578'.dec2bin)
  end

  skip def test_bin_dec2bin!
    # skip
  end
end
