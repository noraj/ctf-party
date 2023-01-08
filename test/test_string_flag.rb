# frozen_string_literal: false

require 'minitest/autorun'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
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
end
