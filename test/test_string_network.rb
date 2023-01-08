# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_network_ipv4?
    assert_equal(true, '1.1.1.1'.ipv4?)
    assert_equal(true, '127.0.0.1'.ipv4?)
    assert_equal(true, '0.0.0.0'.ipv4?)
    assert_equal(true, '255.255.255.255'.ipv4?)
    assert_equal(false, '256.256.256.256'.ipv4?)
    assert_equal(false, '127.0.0.300'.ipv4?)
    assert_equal(false, 'invalid'.ipv4?)
    assert_equal(false, '127.0.0'.ipv4?)
    assert_equal(false, '127.0'.ipv4?)
    assert_equal(false, '127'.ipv4?)
    assert_equal(false, '1.1.1.1x'.ipv4?)
    assert_equal(false, 'x1.1.1.1'.ipv4?)
    assert_equal(false, '🍌.🍌.🍌.🍌'.ipv4?)
  end

  def test_network_ipv6?
    assert_equal(true, '2606:4700:4700::1111'.ipv6?)
    assert_equal(true, '::1'.ipv6?)
    assert_equal(true, '::'.ipv6?)
    assert_equal(true, 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'.ipv6?)
    assert_equal(true, '0:0:0:0:0:0:0:0'.ipv6?)
    assert_equal(true, 'fe80::'.ipv6?)
    assert_equal(false, ':'.ipv6?)
    assert_equal(false, 'fe80::fe80::fe80'.ipv6?)
    assert_equal(false, 'gggg::'.ipv6?)
    assert_equal(false, 'invalid'.ipv6?)
    assert_equal(false, 'ffff:ffff:ffff:ffff:ffff:ffff:ffff'.ipv6?)
    assert_equal(false, 'fe80:'.ipv6?)
    assert_equal(false, 'fe80'.ipv6?)
    assert_equal(false, 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'.ipv6?)
    assert_equal(false, 'fe80::1111x'.ipv6?)
    assert_equal(false, 'xfe80::1111'.ipv6?)
    assert_equal(false, '🍌:🍌:🍌::🍌'.ipv4?)
  end
end
