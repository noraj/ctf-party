# frozen_string_literal: true

# Ruby standard library
require 'cgi'
require 'uri'

class String
  # URL-encode the URL string (RFC 2396)
  # @return [String] the URL-encoded string
  # @example
  #   'http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>'.urlencode # => "http://vulnerable.site/search.aspx?txt=%22%3E%3Cscript%3Ealert(/Rubyfu/.source)%3C/script%3E"
  #   "'Stop!' said Fred".urlencode # => "'Stop!'%20said%20Fred"
  def urlencode
    URI::Parser.new.escape self
  end

  # URL-encode the string in place as described for {String#urlencode}.
  def urlencode!
    replace(urlencode)
  end

  # URL-encode form data (`application/x-www-form-urlencoded`) string
  # @return [String] the URL-encoded data
  # @example
  #   "'Stop!' said Fred".urlencode_data # => "%27Stop%21%27+said+Fred"
  #   'http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>'.urlencode_data # => "http%3A%2F%2Fvulnerable.site%2Fsearch.aspx%3Ftxt%3D%22%3E%3Cscript%3Ealert%28%2FRubyfu%2F.source%29%3C%2Fscript%3E"
  def urlencode_data
    CGI.escape self
  end

  # URL-encode the data in place as described for {String#urlencode_data}.
  def urlencode_data!
    replace(urlencode_data)
  end

  # URL-decode the URL string (RFC 2396)
  # @return [String] the URL-decoded string
  # @example
  #   'http://vulnerable.site/search.aspx?txt=%22%3E%3Cscript%3Ealert(/Rubyfu/.source)%3C/script%3E'.urldecode # => "http://vulnerable.site/search.aspx?txt=\"><script>alert(/Rubyfu/.source)</script>"
  #   'http%3A%2F%2Fvulnerable.site%2Fsearch.aspx%3Ftxt%3D%22%3E%3Cscript%3Ealert%28%2FRubyfu%2F.source%29%3C%2Fscript%3E'.urldecode # => "http://vulnerable.site/search.aspx?txt=\"><script>alert(/Rubyfu/.source)</script>"
  #   "'Stop!'%20said%20Fred".urldecode # => "'Stop!' said Fred"
  #   '%27Stop%21%27+said+Fred'.urldecode # => "'Stop!'+said+Fred"
  def urldecode
    URI::Parser.new.unescape self
  end

  # URL-decode the string in place as described for {String#urldecode}.
  def urldecode!
    replace(urldecode)
  end

  # URL-decode the form data (`application/x-www-form-urlencoded`) string
  # @return [String] the URL-decoded string
  # @example
  #   'http://vulnerable.site/search.aspx?txt=%22%3E%3Cscript%3Ealert(/Rubyfu/.source)%3C/script%3E'.urldecode_data # => "http://vulnerable.site/search.aspx?txt=\"><script>alert(/Rubyfu/.source)</script>"
  #   'http%3A%2F%2Fvulnerable.site%2Fsearch.aspx%3Ftxt%3D%22%3E%3Cscript%3Ealert%28%2FRubyfu%2F.source%29%3C%2Fscript%3E'.urldecode_data # => "http://vulnerable.site/search.aspx?txt=\"><script>alert(/Rubyfu/.source)</script>"
  #   "'Stop!'%20said%20Fred".urldecode_data => "'Stop!' said Fred"
  #   '%27Stop%21%27+said+Fred'.urldecode_data # => "'Stop!' said Fred"
  def urldecode_data
    CGI.unescape self
  end

  # URL-decode the string in place as described for {String#urldecode_data}.
  def urldecode_data!
    replace(urldecode_data)
  end

  # HTML escape the string
  # @return [String] the HTML escaped string
  # @example
  #   'Usage: foo "bar" <baz>'.htmlescape # => "Usage: foo &quot;bar&quot; &lt;baz&gt;"
  def htmlescape
    CGI.escapeHTML self
  end

  # HTML escape the string in place as described for {String#htmlescape}.
  def htmlescape!
    replace(htmlescape)
  end

  # HTML unescape the string
  # @return [String] the HTML unescaped string
  # @example
  #   "Usage: foo &quot;bar&quot; &lt;baz&gt;".htmlunescape # => "Usage: foo \"bar\" <baz>"
  def htmlunescape
    CGI.unescapeHTML self
  end

  # HTML unescape the string in place as described for {String#htmlunescape}.
  def htmlunescape!
    replace(htmlunescape)
  end

  # URL-encode the URL component string (RFC 3986)
  # @return [String] URL-encoded component string
  # @example
  #   'http://vulnerable.site/search.aspx?txt="><script>alert(/Rubyfu/.source)</script>'.urlencode_component # => "http%3A%2F%2Fvulnerable.site%2Fsearch.aspx%3Ftxt%3D%22%3E%3Cscript%3Ealert%28%2FRubyfu%2F.source%29%3C%2Fscript%3E"
  #   "'Stop!' said Fred".urlencode_component # => "%27Stop%21%27%20said%20Fred"
  def urlencode_component
    CGI.escapeURIComponent self
  end

  # URL-encode the URL component string (RFC 3986) as described for {String#urlencode_component}.
  def urlencode_component!
    replace(urlencode_component)
  end

  # URL-decode the URL component string (RFC 3986)
  # @return [String] URL-decoded component string
  # @example
  #   'http%3A%2F%2Fvulnerable.site%2Fsearch.aspx%3Ftxt%3D%22%3E%3Cscript%3Ealert%28%2FRubyfu%2F.source%29%3C%2Fscript%3E'.urldecode_component # => "http://vulnerable.site/search.aspx?txt=\"><script>alert(/Rubyfu/.source)</script>"
  #   '%27Stop%21%27%20said%20Fred'.urldecode_component # => "'Stop!' said Fred"
  def urldecode_component
    CGI.unescapeURIComponent self
  end

  # URL-decode the URL component string (RFC 3986) as described for {String#urldecode_component}.
  def urldecode_component!
    replace(urldecode_component)
  end
end
