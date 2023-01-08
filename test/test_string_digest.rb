# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
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
end
