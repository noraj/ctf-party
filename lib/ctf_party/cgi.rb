# frozen_string_literal: true

# Ruby standard library
require 'cgi'

class String
  # URL-encode the string
  # @return [String] the URL-encoded string
  # @example
  #   "'Stop!' said Fred".urlencode # => "%27Stop%21%27+said+Fred"
  def urlencode
    CGI.escape self
  end

  # URL-encode the string in place as described for {String#urlencode}.
  def urlencode!
    replace(urlencode)
  end

  # URL-decode the string
  # @return [String] the URL-decoded string
  # @example
  #   "%27Stop%21%27+said+Fred".urldecode # => "'Stop!' said Fred"
  def urldecode
    CGI.unescape self
  end

  # URL-decode the string in place as described for {String#urldecode}.
  def urldecode!
    replace(urldecode)
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
end
