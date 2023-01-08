# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_leet_leet
    assert_equal('7h3 qu1ck 8r0wn f0x jump5 0v3r 7h3 14zy d06', 'The quick brown fox jumps over the lazy dog'.leet)
    assert_equal('P4ck my 80x w17h f1v3 d0z3n 11qu0r ju65', 'Pack my box with five dozen liquor jugs'.leet)
  end

  skip def test_leet_leet!
    # skip
  end
end
