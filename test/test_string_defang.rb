# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_defang_ip
    assert_equal('1[.]1[.]1[.]1', '1.1.1.1'.defang_ip)
    assert_equal('invalid', 'invalid'.defang_ip)
    assert_equal('127.0.0', '127.0.0'.defang_ip)
    assert_equal('x1.1.1.1', 'x1.1.1.1'.defang_ip)
    assert_equal('🍌[.]🍌[.]🍌[.]🍌', '🍌.🍌.🍌.🍌'.defang_ip(unvalid: true))
    assert_equal('[:][:]1', '::1'.defang_ip)
    assert_equal('gggg::', 'gggg::'.defang_ip)
    assert_equal('gggg[:][:]', 'gggg::'.defang_ip(unvalid: true))
  end

  def test_defang_ip!
    my_str = '127.0.0.1'
    my_str.defang_ip!
    assert_equal('127[.]0[.]0[.]1', my_str)
    my_str2 = '500.0.0.1'
    my_str2.defang_ip!(unvalid: true)
    assert_equal('500[.]0[.]0[.]1', my_str2)
  end

  def test_refang_ip
    assert_equal('1.1.1.1', '1[.]1[.]1[.]1'.refang_ip)
    assert_equal('300[.]300[.]300[.]300', '300[.]300[.]300[.]300'.refang_ip)
    assert_equal('2606:4700:4700::1111', '2606[:]4700[:]4700[:][:]1111'.refang_ip)
    assert_equal('fe80::1111x', 'fe80[:][:]1111x'.refang_ip(unvalid: true))
  end

  def test_refang_ip!
    mystr = 'fe80[:]'
    mystr.refang_ip!(unvalid: true)
    assert_equal('fe80:', mystr)
  end
end
