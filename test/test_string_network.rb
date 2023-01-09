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
    assert_equal(false, '🍌:🍌:🍌::🍌'.ipv6?)
  end

  def test_network_ip?
    assert_equal(true, '1.1.1.1'.ip?)
    assert_equal(true, '2606:4700:4700::1111'.ip?)
    assert_equal(false, 'invalid'.ip?)
    assert_equal(false, '🍌.🍌.🍌::🍌'.ip?)
  end

  def test_network_uri?
    assert_equal(true, 'ftp://ftp.ruby-lang.org/pub/ruby/3.2/ruby-3.2.0.tar.xz'.uri?)
    assert_equal(true, 'http://noraj.neverssl.com/online/'.uri?)
    assert_equal(true, 'https://pwn.by/noraj/?id=42&countre=France#awesome'.uri?)
    assert_equal(true, 'ldap://ldap.example.org/cn=John%20Doe,dc=example,dc=org'.uri?)
    assert_equal(true, 'ldaps:///dc=example,dc=org??sub?(givenName=John)'.uri?)
    assert_equal(true, 'mailto:noraj@rubyfu.net?subject=Hack the planet&cc=contact@rubyfu.net&bcc=love@rubyfu.net&body=Bonjour'.uri?)
    assert_equal(true, 'ws://example.org/chat'.uri?)
    assert_equal(true, 'wss://javascript.info/article/websocket/demo/hello'.uri?)
    assert_equal(true, 'gopher://gopher.floodgap.com/1/overbite/'.uri?(lax: true))
    assert_equal(true, 'magnet:?xt=urn:btih:fef84077088ca87ffd8afd644d0ef957d96243c3&dn=archlinux-2023.01.01-x86_64.iso'.uri?(lax: true))
    assert_equal(true, 'matrix:r/BlackArch%3Amatrix.org?action=join&via=matrix.org'.uri?(lax: true))
    assert_equal(false, 'invalid'.uri?)
    assert_equal(false, 'invalid'.uri?(lax: true))
    assert_equal(false, 'a:'.uri?)
    assert_equal(true, 'a:'.uri?(lax: true))
    assert_equal(true, 'http:'.uri?)
  end
end
