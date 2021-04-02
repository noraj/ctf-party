# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
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

  def test_digest_md5
    assert_equal('556cc23863fef20fab5c456db166bc6e', 'noraj'.md5)
  end

  def test_digest_md5!
    a = '\o/'
    a.md5!
    assert_equal('881419964e480e66162da521ccc25ebf', a)
  end

  def test_digest_sha1
    assert_equal('5a64f3bc491d0977e1e3578a48c65a89a16a5fe8', 'ctf-party'.sha1)
  end

  def test_digest_sha1!
    bob = 'alice'
    bob.sha1!
    assert_equal('522b276a356bdf39013dfabea2cd43e141ecc9e8', bob)
  end

  def test_digest_sha2
    assert_equal('5321ff2d4b1389b3a350dfe8ca77e3889dc6259bb233adfd069f0f6c474ba128', 'try harder'.sha2)
  end

  def test_digest_sha2!
    th = 'try harder'
    th.sha2!(bitlen: 384)
    assert_equal('bb7f60b9562a19c3a83c23791440af11591c42ede9988334cdfd7efa4261a3d493d594d08aae5c3b63c7680297ea8f16', th)
  end

  def test_digest_sha2_256
    assert_equal(''.sha2, ''.sha2_256)
  end

  skip def test_digest_sha2_256!
    # skip
  end

  def test_digest_sha2_384
    assert_equal(''.sha2(bitlen: 384), ''.sha2_384)
  end

  skip def test_digest_sha2_384!
    # skip
  end

  def test_digest_sha2_512
    assert_equal(''.sha2(bitlen: 512), ''.sha2_512)
  end

  skip def test_digest_sha2_512!
    # skip
  end

  def test_digest_rmd160
    assert_equal('3c6255c112d409dafdb84d5b0edba98dfd27b44f', 'payload'.rmd160)
  end

  def test_digest_rmd160!
    pl = 'payload'
    pl.rmd160!
    assert_equal('3c6255c112d409dafdb84d5b0edba98dfd27b44f', pl)
  end

  def test_flag_flag
    hash = { prefix: 'sigsegv', suffix: '', enclosing: ['{', '}'], digest: 'md5' }
    String.flag = hash
    assert_equal(hash, String.flag)
    assert_equal('sigsegv{a5bec9e2a86b6b70d288451eb38dfec8}', 'this_1s_a_fl4g'.flag)
  end

  def test_flag_flag?
    String.flag = { prefix: 'flag', suffix: '', enclosing: ['{', '}'], digest: nil }
    flag = 'Brav0!'
    flag.flag!
    assert_equal('flag{Brav0!}', flag)
    assert(flag.flag?)
    flag = 'ctf{Brav0!}'
    refute(flag.flag?)
  end

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

  def test_hex_hex2dec
    assert_equal('255', 'ff'.hex2dec)
    assert_equal('243', '\xf3'.hex2dec(prefix: '\x'))
  end

  skip def test_hex_hex2dec!
    # skip
  end

  def test_hex_dec2hex
    assert_equal('ff', '255'.dec2hex)
    assert_equal('0xFF', '255'.dec2hex(prefix: '0x', case: :upper))
  end

  skip def test_hex_dec2hex!
    # skip
  end

  def test_hex_to_hex
    assert_equal('6e6f72616a', 'noraj'.to_hex)
    assert_equal('0x6e6f72616a', 'noraj'.to_hex(prefix: '0x'))
    assert_equal('6E6F72616A', 'noraj'.to_hex(case: :upper))
    assert_equal('e6f62716a6', 'noraj'.to_hex(nibble: :low))
  end

  skip def test_hex_to_hex!
    # skip
  end

  def test_hex_from_hex
    assert_equal('noraj', '6e6f72616a'.from_hex)
    assert_equal('noraj', '0x6e6f72616a'.from_hex(prefix: '0x'))
    assert_equal('noraj', 'e6f62716a6'.from_hex(nibble: :low))
  end

  skip def test_hex_from_hex!
    # skip
  end

  def test_hex_hex2bin
    assert_equal('10101011', 'ab'.hex2bin)
    assert_equal('11110011', '\xf3'.hex2bin(prefix: '\x'))
  end

  skip def test_hex_hex2bin!
    # skip
  end

  def test_hex_bin2hex
    assert_equal('f3', '11110011'.bin2hex)
    assert_equal('0xF3', '11110011'.bin2hex(prefix: '0x', case: :upper))
  end

  skip def test_hex_bin2hex!
    # skip
  end

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

  def test_hex_str2hex
    my_str = 'AAAA'
    assert_equal(my_str.to_hex, my_str.str2hex)
  end

  skip def test_hex_str2hex!
    # skip
  end

  def test_hex_hex2str
    my_str = '41414141'
    assert_equal(my_str.from_hex, my_str.hex2str)
  end

  skip def test_hex_hex2str!
    # skip
  end

  def test_cgi_urlencode
    my_str = "'Stop!' said Fred"
    assert_equal('%27Stop%21%27+said+Fred', my_str.urlencode)
  end

  skip def test_cgi_urlencode!
    # skip
  end

  def test_cgi_urldecode
    my_str = '%27Stop%21%27+said+Fred'
    assert_equal("'Stop!' said Fred", my_str.urldecode)
  end

  skip def test_cgi_urldecode!
    # skip
  end

  def test_cgi_htmlescape
    my_str = 'Usage: foo "bar" <baz>'
    assert_equal('Usage: foo &quot;bar&quot; &lt;baz&gt;', my_str.htmlescape)
  end

  skip def test_cgi_htmlescape!
    # skip
  end

  def test_cgi_htmlunescape
    my_str = 'Usage: foo &quot;bar&quot; &lt;baz&gt;'
    assert_equal('Usage: foo "bar" <baz>', my_str.htmlunescape)
  end

  skip def test_cgi_htmlunescape!
    # skip
  end

  def test_bin_to_bin
    my_str = 'binary'
    assert_equal('011000100110100101101110011000010111001001111001', my_str.to_bin)
    assert_equal('010001101001011001110110100001100100111010011110', my_str.to_bin(bitnumbering: :LSB))
    assert_equal(my_str.to_bin, my_str.to_bin(bitnumbering: :MSB))
  end

  skip def test_bin_to_bin!
    # skip
  end

  def test_bin_str2bin
    my_str = 'binary'
    assert_equal(my_str.to_bin, my_str.str2bin)
    assert_equal(my_str.to_bin(bitnumbering: :LSB), my_str.str2bin(bitnumbering: :LSB))
  end

  skip def test_bin_str2bin!
    # skip
  end

  def test_bin_from_bin
    my_str = 'binary'
    assert_equal(my_str, '011000100110100101101110011000010111001001111001'.from_bin)
    assert_equal(my_str, '010001101001011001110110100001100100111010011110'.from_bin(bitnumbering: :LSB))
    assert_equal(my_str, '011000100110100101101110011000010111001001111001'.from_bin(bitnumbering: :MSB))
  end

  skip def test_bin_from_bin!
    # skip
  end

  def test_bin_bin2str
    my_str1 = '011000100110100101101110011000010111001001111001'
    my_str2 = '010001101001011001110110100001100100111010011110'
    assert_equal(my_str1.from_bin, my_str1.bin2str)
    assert_equal(my_str2.from_bin(bitnumbering: :LSB), my_str2.bin2str(bitnumbering: :LSB))
  end

  skip def test_bin_bin2str!
    # skip
  end

  def test_hex_from_hexip
    ip = '127.0.0.1'
    assert_equal(ip, '0100007F'.from_hexip(nibble: :low))
    assert_equal(ip, '0x7f000001'.from_hexip(prefix: '0x'))
  end

  skip def test_hex_from_hexip!
    # skip
  end

  def test_hex_to_hexip
    ip = '127.0.0.1'
    assert_equal('7f000001', ip.to_hexip)
    assert_equal('0100007f', ip.to_hexip(nibble: :low))
  end

  skip def test_hex_to_hexip!
    # skip
  end

  def test_leet_leet
    assert_equal('7h3 qu1ck 8r0wn f0x jump5 0v3r 7h3 14zy d06', 'The quick brown fox jumps over the lazy dog'.leet)
    assert_equal('P4ck my 80x w17h f1v3 d0z3n 11qu0r ju65', 'Pack my box with five dozen liquor jugs'.leet)
  end

  skip def test_leet_leet!
    # skip
  end

  def test_dec_to_dec
    assert_equal('474316169578', 'noraj'.to_dec)
  end

  skip def test_dec_to_dec!
    # skip
  end

  def test_dec_from_dec
    assert_equal('ctf-party', '1834615104613964215417'.from_dec)
  end

  skip def test_dec_from_dec!
    # skip
  end

  def test_dec_str2dec
    my_str = 'noraj'
    assert_equal(my_str.to_dec, my_str.str2dec)
  end

  skip def test_dec_str2dec!
    # skip
  end

  def test_dec_dec2str
    my_str = '1834615104613964215417'
    assert_equal(my_str.from_dec, my_str.dec2str)
  end

  skip def test_dec_dec2str!
    # skip
  end
end
