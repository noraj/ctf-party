# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_defang_defang_ip
    assert_equal('1[.]1[.]1[.]1', '1.1.1.1'.defang_ip)
    assert_equal('invalid', 'invalid'.defang_ip)
    assert_equal('127.0.0', '127.0.0'.defang_ip)
    assert_equal('x1.1.1.1', 'x1.1.1.1'.defang_ip)
    assert_equal('🍌[.]🍌[.]🍌[.]🍌', '🍌.🍌.🍌.🍌'.defang_ip(unvalid: true))
    assert_equal('[:][:]1', '::1'.defang_ip)
    assert_equal('gggg::', 'gggg::'.defang_ip)
    assert_equal('gggg[:][:]', 'gggg::'.defang_ip(unvalid: true))
  end

  def test_defang_defang_ip!
    my_str = '127.0.0.1'
    my_str.defang_ip!
    assert_equal('127[.]0[.]0[.]1', my_str)
    my_str2 = '500.0.0.1'
    my_str2.defang_ip!(unvalid: true)
    assert_equal('500[.]0[.]0[.]1', my_str2)
  end

  def test_defang_refang_ip
    assert_equal('1.1.1.1', '1[.]1[.]1[.]1'.refang_ip)
    assert_equal('300[.]300[.]300[.]300', '300[.]300[.]300[.]300'.refang_ip)
    assert_equal('2606:4700:4700::1111', '2606[:]4700[:]4700[:][:]1111'.refang_ip)
    assert_equal('fe80::1111x', 'fe80[:][:]1111x'.refang_ip(unvalid: true))
  end

  def test_defang_refang_ip!
    mystr = 'fe80[:]'
    mystr.refang_ip!(unvalid: true)
    assert_equal('fe80:', mystr)
  end

  def test_defang_defang_uri
    assert_equal('fxp://ftp[.]ruby-lang[.]org/pub/ruby/3[.]2/ruby-3[.]2[.]0[.]tar[.]xz', 'ftp://ftp.ruby-lang.org/pub/ruby/3.2/ruby-3.2.0.tar.xz'.defang_uri)
    assert_equal('hxxp://noraj[.]neverssl[.]com/online/', 'http://noraj.neverssl.com/online/'.defang_uri)
    assert_equal('hxxps://pwn[.]by/noraj/?id=42&countre=France#awesome', 'https://pwn.by/noraj/?id=42&countre=France#awesome'.defang_uri)
    assert_equal('ldxap://ldap[.]example[.]org/cn=John%20Doe,dc=example,dc=org','ldap://ldap.example.org/cn=John%20Doe,dc=example,dc=org'.defang_uri)
    unless RUBY_VERSION[..2] == '3.0' # probably because this is not backported https://github.com/ruby/ruby/pull/7260
      # special case with implied address and port
      assert_equal('ldxaps:///dc=example,dc=org??sub?(givenName=John)', 'ldaps:///dc=example,dc=org??sub?(givenName=John)'.defang_uri)
    else
      # full set
      assert_equal('ldxaps://ds[.]example[.]com:389/dc=example,dc=com?givenName,sn,cn?sub?(uid=john[.]doe)', 'ldaps://ds.example.com:389/dc=example,dc=com?givenName,sn,cn?sub?(uid=john.doe)'.defang_uri)
    end
    assert_equal('mailxto:noraj[@]rubyfu[.]net?subject=Hack the planet&cc=contact[@]rubyfu[.]net&bcc=love[@]rubyfu[.]net&body=Bonjour', 'mailto:noraj@rubyfu.net?subject=Hack the planet&cc=contact@rubyfu.net&bcc=love@rubyfu.net&body=Bonjour'.defang_uri)
    assert_equal('wxs://example[.]org/chat', 'ws://example.org/chat'.defang_uri)
    assert_equal('wxss://javascript[.]info/article/websocket/demo/hello', 'wss://javascript.info/article/websocket/demo/hello'.defang_uri)
    assert_equal('gopher://gopher[.]floodgap[.]com/1/overbite/', 'gopher://gopher.floodgap.com/1/overbite/'.defang_uri)
    assert_equal('magnet:?xt=urn:btih:fef84077088ca87ffd8afd644d0ef957d96243c3&dn=archlinux-2023[.]01[.]01-x86_64[.]iso', 'magnet:?xt=urn:btih:fef84077088ca87ffd8afd644d0ef957d96243c3&dn=archlinux-2023.01.01-x86_64.iso'.defang_uri)
    assert_equal('matrix:r/BlackArch%3Amatrix[.]org?action=join&via=matrix[.]org', 'matrix:r/BlackArch%3Amatrix.org?action=join&via=matrix.org'.defang_uri)
  end

  def test_defang_defang_uri!
    mystr = 'https://writeup.raw.pm/'
    mystr.defang_uri!
    assert_equal('hxxps://writeup[.]raw[.]pm/', mystr)
  end

  def test_defang_refang_uri
    ftp = 'ftp://ftp.ruby-lang.org/pub/ruby/3.2/ruby-3.2.0.tar.xz'
    http = 'http://noraj.neverssl.com/online/'
    https = 'https://pwn.by/noraj/?id=42&countre=France#awesome'
    ldap = 'ldap://ldap.example.org/cn=John%20Doe,dc=example,dc=org'
    ldaps = 'ldaps://ds.example.com:389/dc=example,dc=com?givenName,sn,cn?sub?(uid=john.doe)'
    mailto = 'mailto:noraj@rubyfu.net?subject=Hack the planet&cc=contact@rubyfu.net&bcc=love@rubyfu.net&body=Bonjour'
    ws = 'ws://example.org/chat'
    wss = 'wss://javascript.info/article/websocket/demo/hello'
    gopher = 'gopher://gopher.floodgap.com/1/overbite/'
    magnet = 'magnet:?xt=urn:btih:fef84077088ca87ffd8afd644d0ef957d96243c3&dn=archlinux-2023.01.01-x86_64.iso'
    matrix = 'matrix:r/BlackArch%3Amatrix.org?action=join&via=matrix.org'
    [ftp, http, https, ldap, ldaps, mailto, ws, wss, gopher, magnet, matrix].each do |uri|
      assert_equal(uri, uri.defang_uri.refang_uri)
    end
  end

  def test_defang_refang_uri!
    mystr = 'hxxps://writeup[.]raw[.]pm/'
    mystr.refang_uri!
    assert_equal('https://writeup.raw.pm/', mystr)
  end

  def test_defang_defang_domain
    assert_equal('pwn[.]by', 'pwn.by'.defang_domain)
    assert_equal('inventory[.]raw[.]pm', 'inventory.raw.pm'.defang_domain)
    assert_equal('4programmer[.]com', '4programmer.com'.defang_domain)
    assert_equal('arachni-scanner[.]com', 'arachni-scanner.com'.defang_domain)
    assert_equal('xn--en8h[.]cf', 'xn--en8h.cf'.defang_domain)
    assert_equal('🏳[.]cf', '🏳.cf'.defang_domain)
    assert_equal("#{'a' * 255}.com", "#{'a' * 255}.com".defang_domain)
    assert_equal("#{'a.' * 128}.com", "#{'a.' * 128}.com".defang_domain)
    assert_equal('notld', 'notld'.defang_domain)
    assert_equal('.startwithadot.org', '.startwithadot.org'.defang_domain)
    assert_equal("#{'a' * 64}.net", "#{'a' * 64}.net".defang_domain)
    assert_equal('a.-b.net', 'a.-b.net'.defang_domain)
    assert_equal('a.c-.net', 'a.c-.net'.defang_domain)
    assert_equal('a..d.net', 'a..d.net'.defang_domain)
    assert_equal("\u{001F}.com", "\u{001F}.com".defang_domain)
    assert_equal('[.]startwithadot[.]org', '.startwithadot.org'.defang_domain(unvalid: true))
    assert_equal('a[.][.]d[.]net', 'a..d.net'.defang_domain(unvalid: true))
  end

  def test_defang_defang_domain!
    mystr = 'noraj.github.io'
    mystr.defang_domain!
    assert_equal('noraj[.]github[.]io', mystr)
  end

  def test_defang_refang_domain
    assert_equal('pwn.by', 'pwn[.]by'.refang_domain)
    assert_equal('inventory.raw.pm', 'inventory[.]raw[.]pm'.refang_domain)
    assert_equal('4programmer.com', '4programmer[.]com'.refang_domain)
    assert_equal('arachni-scanner.com', 'arachni-scanner[.]com'.refang_domain)
    assert_equal('xn--en8h.cf', 'xn--en8h[.]cf'.refang_domain)
    assert_equal('🏳.cf', '🏳[.]cf'.refang_domain)
    assert_equal("#{'a' * 255}.com", "#{'a' * 255}.com".refang_domain)
    assert_equal("#{'a.' * 128}.com", "#{'a.' * 128}.com".refang_domain)
    assert_equal('notld', 'notld'.refang_domain)
    assert_equal('.startwithadot.org', '.startwithadot.org'.refang_domain)
    assert_equal("#{'a' * 64}.net", "#{'a' * 64}.net".refang_domain)
    assert_equal('a.-b.net', 'a.-b.net'.refang_domain)
    assert_equal('a.c-.net', 'a.c-.net'.refang_domain)
    assert_equal('a..d.net', 'a..d.net'.refang_domain)
    assert_equal("\u{001F}.com", "\u{001F}.com".refang_domain)
    assert_equal('.startwithadot.org', '[.]startwithadot[.]org'.refang_domain(unvalid: true))
    assert_equal('a..d.net', 'a[.][.]d[.]net'.refang_domain(unvalid: true))
  end

  def test_defang_refang_domain!
    mystr = 'noraj[.]github[.]io'
    mystr.refang_domain!
    assert_equal('noraj.github.io', mystr)
  end

  def test_defang_defang_email
    overlong = "n#{'o' * 255}raj@pwn.by"
    alias_ = 'noraj+alias@pwn.by'
    dot = 'noraj.rawsec@pwn.by'
    under = '_valid@ruby.org'
    special = 'valid%$@domain.com'
    quoted = '"valid"@domain.com'
    assert_equal("n#{'o' * 255}raj[@]pwn[.]by", overlong.defang_email)
    assert_equal('noraj+alias[@]pwn[.]by', alias_.defang_email)
    assert_equal('noraj[.]rawsec[@]pwn[.]by', dot.defang_email)
    assert_equal('_valid[@]ruby[.]org', under.defang_email)
    assert_equal('valid%$[@]domain[.]com', special.defang_email)
    assert_equal('"valid"[@]domain[.]com', quoted.defang_email)
    ['.@toto.fr', '-@z', '++++++++.........@z', 'invalíd@mail.com', 'invalid%$£"@domain.com', 'invalid£@domain.com', 'invali"d@domain.com', '.dot..dot.@example.org', '!#$%’*+-/=?^_`{|}~@example.org'].each do |email|
      assert_equal(email, email.defang_email)
    end
    assert_equal('[.][@]toto[.]fr', '.@toto.fr'.defang_email(unvalid: true))
  end

  def test_defang_defang_email!
    mystr = 'invalid£@domain.com'
    mystr.defang_email!(unvalid: true)
    assert_equal('invalid£[@]domain[.]com', mystr)
  end

  def test_defang_refang_email
    overlong = "n#{'o' * 255}raj@pwn.by"
    alias_ = 'noraj+alias@pwn.by'
    dot = 'noraj.rawsec@pwn.by'
    under = '_valid@ruby.org'
    special = 'valid%$@domain.com'
    quoted = '"valid"@domain.com'
    [overlong, alias_, dot, under, special, quoted].each do |email|
      assert_equal(email, email.defang_email.refang_email)
    end
    ['.@toto.fr', '-@z', '++++++++.........@z', 'invalíd@mail.com', 'invalid%$£"@domain.com', 'invalid£@domain.com', 'invali"d@domain.com', '.dot..dot.@example.org', '!#$%’*+-/=?^_`{|}~@example.org'].each do |email|
      assert_equal(email, email.defang_email(unvalid: true).refang_email(unvalid: true))
    end
  end

  def test_defang_refang_email!
    mystr = 'invalid£[@]domain[.]com'
    mystr.refang_email!(unvalid: true)
    assert_equal('invalid£@domain.com', mystr)
  end
end
