# frozen_string_literal: false

require_relative 'test_helper'

class CTFPartyTest < Minitest::Test
  def test_case_randomcase
    my_str = 'SELECT * FROM'
    refute_equal(my_str, my_str.randomcase)
  end

  skip def test_case_randomcase!
    # skip
  end

  def test_case_alternatecase
    my_str = 'SELECT * FROM'
    assert_equal('sElEcT * FrOm', my_str.alternatecase)
    assert_equal('SeLeCt * fRoM', my_str.alternatecase(1))
  end

  skip def test_case_alternatecase!
    # skip
  end
end
