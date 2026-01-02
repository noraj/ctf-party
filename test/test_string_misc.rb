# frozen_string_literal: false

require_relative 'test_helper'

class CTFPartyTest < Minitest::Test
  def test_misc_istrip
    assert_equal('HelloWorld!', "\t\n\v\f\r Hello \t\n\v\f\r World !\t\n\v\f\r ".istrip)
    assert_equal('7374726970', '73 74 72 69 70'.istrip)
  end

  skip def test_misc_istrip!
    # skip
  end
end
