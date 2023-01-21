# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'ctf_party'

class CTFPartyTest < Minitest::Test
  def test_cgi_urlencode
    my_url = 'http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>'
    my_url_component = "'Stop!' said Fred"
    assert_equal('http://vulnerable.site/search.aspx?txt=%22%3E%3Cscript%3Ealert(/Rubyfu/.source)%3C/script%3E', my_url.urlencode)
    assert_equal("'Stop!'%20said%20Fred", my_url_component.urlencode)
  end

  skip def test_cgi_urlencode!
    # skip
  end

  def test_cgi_urlencode_component
    my_url = 'http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>'
    my_url_component = "'Stop!' said Fred"
    assert_equal("http%3A%2F%2Fvulnerable.site%2Fsearch.aspx%3Ftxt%3D%22%3E%3Cscript%3Ealert%28%2FRubyfu%2F.source%29%3C%2Fscript%3E", my_url.urlencode_component)
    assert_equal("%27Stop%21%27+said+Fred", my_url_component.urlencode_component)
  end

  skip def test_cgi_urlencode_component!
    # skip
  end

  def test_cgi_urldecode
    my_url = 'http://vulnerable.site/search.aspx?txt=%22%3E%3Cscript%3Ealert(/Rubyfu/.source)%3C/script%3E'
    my_url2 = 'http%3A%2F%2Fvulnerable.site%2Fsearch.aspx%3Ftxt%3D%22%3E%3Cscript%3Ealert%28%2FRubyfu%2F.source%29%3C%2Fscript%3E'
    my_url_component = "'Stop!'%20said%20Fred"
    my_url_component2 = '%27Stop%21%27+said+Fred'
    assert_equal('http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>', my_url.urldecode)
    assert_equal('http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>', my_url2.urldecode)
    assert_equal("'Stop!' said Fred", my_url_component.urldecode)
    assert_equal("'Stop!'+said+Fred", my_url_component2.urldecode)
  end

  skip def test_cgi_urldecode!
    # skip
  end

  def test_cgi_urldecode_component
    my_url = 'http://vulnerable.site/search.aspx?txt=%22%3E%3Cscript%3Ealert(/Rubyfu/.source)%3C/script%3E'
    my_url2 = 'http%3A%2F%2Fvulnerable.site%2Fsearch.aspx%3Ftxt%3D%22%3E%3Cscript%3Ealert%28%2FRubyfu%2F.source%29%3C%2Fscript%3E'
    my_url_component = "'Stop!'%20said%20Fred"
    my_url_component2 = '%27Stop%21%27+said+Fred'
    assert_equal('http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>', my_url.urldecode_component)
    assert_equal('http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>', my_url2.urldecode_component)
    assert_equal("'Stop!' said Fred", my_url_component.urldecode_component)
    assert_equal("'Stop!' said Fred", my_url_component2.urldecode_component)
  end

  skip def test_cgi_urldecode_component!
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
end
