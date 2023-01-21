# frozen_string_literal: false

require 'minitest/autorun'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_base64_to_b64
    assert_equal('U3VwZXIgbGliIQ==', 'Super lib!'.to_b64)
  end

  def test_base64_to_b64!
    my_str = 'Ruby'
    my_str.to_b64!
    assert_equal('UnVieQ==', my_str)
  end

  def test_base64_from_b64
    assert_equal('Ruby', 'UnVieQ=='.from_b64)
  end

  def test_base64_from_b64!
    a = 'SGVsbG8gd29ybGQh'
    a.from_b64!
    assert_equal('Hello world!', a)
  end

  def test_base64_b64?
    assert('SGVsbG8gd29ybGQh'.b64?)
    refute('SGVsbG8g@@d29ybGQh'.b64?)
  end
end
