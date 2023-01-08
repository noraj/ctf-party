# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_rot_rot
    assert_equal('Uryyb jbeyq!', 'Hello world!'.rot)
    assert_equal('Spwwz hzcwo!', 'Hello world!'.rot(shift: 11))
    assert_equal('Hello world!', 'Uryyb jbeyq!'.rot)
    assert_equal('Hello world!', 'Spwwz hzcwo!'.rot(shift: 26 - 11))
  end

  def test_rot_rot!
    a = 'Bonjour le monde !'
    a.rot!
    assert_equal('Obawbhe yr zbaqr !', a)
  end

  def test_rot_rot13
    assert_equal('Ab'.rot, 'Ab'.rot13)
  end

  skip def test_rot_rot13!
    # skip
  end

  def test_rot_rot_all
    assert_equal('yzclu', 'noraj'.rot_all[11])
    assert_equal('noraj', 'noraj'.rot_all[26])
  end
end
