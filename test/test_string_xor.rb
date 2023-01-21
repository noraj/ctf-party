# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_xor_ulxor
    assert_equal("he\a\t\u0016", 'hello'.ulxor('key'))
    assert_equal("he\a\t\u0016", 'key'.ulxor('hello'))
  end

  skip def test_xor_ulxor!
    # skip
  end

  def test_xor_alxor
    assert_equal("he\a\t\x16", 'hello'.alxor('key'))
    assert_equal("he\a\t\x16", 'key'.alxor('hello'))
  end

  skip def test_xor_alxor!
    # skip
  end

  def test_xor_urxor
    assert_equal("\u0003\u0000\u0015lo", 'hello'.urxor('key'))
  end

  skip def test_xor_urxor!
    # skip
  end

  def test_xor_arxor
    assert_equal("\x03\x00\x15lo", 'hello'.arxor('key'))
    assert_equal("\x03\x00\x15lo", 'key'.arxor('hello'))
  end

  skip def test_xor_arxor!
    # skip
  end
end
