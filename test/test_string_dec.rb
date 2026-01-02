# frozen_string_literal: false

require_relative 'test_helper'

class CTFPartyTest < Minitest::Test
  def test_dec_to_dec
    assert_equal('474316169578', 'noraj'.to_dec)
  end

  skip def test_dec_to_dec!
    # skip
  end

  def test_dec_from_dec
    assert_equal('ctf-party', '1834615104613964215417'.from_dec)
  end

  skip def test_dec_from_dec!
    # skip
  end

  def test_dec_str2dec
    my_str = 'noraj'
    assert_equal(my_str.to_dec, my_str.str2dec)
  end

  skip def test_dec_str2dec!
    # skip
  end

  def test_dec_dec2str
    my_str = '1834615104613964215417'
    assert_equal(my_str.from_dec, my_str.dec2str)
  end

  skip def test_dec_dec2str!
    # skip
  end
end
