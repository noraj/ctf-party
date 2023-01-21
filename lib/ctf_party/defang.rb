# frozen_string_literal: true

require 'ipaddr'
require 'uri'

class String
  # Defang the string if it is an IP address
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :unvalid Default value: `false`.
  #   If `unvalid: false`, only valid IP address will be defanged.
  #   If `unvalid: true`, everything is defanged.
  # @return [String] the defanged string if it is a valid IP address or itself else.
  # @example
  #   '1.1.1.1'.defang_ip # => 1[.]1[.]1[.]1
  #   '2606:4700:4700::1111'.defang_ip # => '2606[:]4700[:]4700[:][:]1111'
  def defang_ip(opts = {})
    opts[:unvalid] ||= false
    if ipv4?
      gsub('.', '[.]')
    elsif ipv6?
      gsub(':', '[:]')
    elsif opts[:unvalid] == true
      gsub('.', '[.]').gsub(':', '[:]')
    else
      self
    end
  end

  # Defang the string in place, if it is an IP address, as described for {String#defang_ip}.
  # @return [nil]
  # @example
  #   my_str = '127.0.0.1'
  #   my_str.defang_ip!
  #   my_str # => 127[.]0[.]0[.]1
  def defang_ip!(opts = {})
    replace(defang_ip(opts))
  end

  # Refang the string if it is an IP address
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :unvalid Default value: `false`.
  #   If `unvalid: false`, only valid IP address will be refanged.
  #   If `unvalid: true`, everything is refanged.
  # @return [String] the refanged string if it is a valid IP address or itself else.
  # @example
  #   '1[.]1[.]1[.]1'.refang_ip # => 1.1.1.1
  #   '2606[:]4700[:]4700[:][:]1111'.refang_ip # => 2606:4700:4700::1111
  def refang_ip(opts = {})
    opts[:unvalid] ||= false
    re_ipv4 = gsub('[.]', '.')
    re_ipv6 = gsub('[:]', ':')
    if re_ipv4.ipv4?
      re_ipv4
    elsif re_ipv6.ipv6?
      re_ipv6
    elsif opts[:unvalid] == true
      gsub('[.]', '.').gsub('[:]', ':')
    else
      self
    end
  end

  # Refang the string in place, if it is an IP address, as described for {String#refang_ip}.
  # @return [nil]
  def refang_ip!(opts = {})
    replace(refang_ip(opts))
  end

  # Defang the string if it is an URI.
  # Will defang dot for any scheme and defang scheme as well for supported ones.
  # Supported schemes: HTTP, HTTPS, FTP, WS, WSS, LDAP, LDAPS, Mailto.
  # @return [String] the defanged string if it is an URI or itself else.
  # @example
  #   'ftp://ftp.ruby-lang.org/pub/ruby/3.2/ruby-3.2.0.tar.xz'.defang_uri
  #   # => fxp://ftp[.]ruby-lang[.]org/pub/ruby/3[.]2/ruby-3[.]2[.]0[.]tar[.]xz
  def defang_uri
    begin
      uri = URI(self)
    rescue URI::InvalidURIError, URI::InvalidComponentError => e
      puts e
      return gsub('.', '[.]')
    end
    case uri
    when URI::HTTP, URI::HTTPS, URI::FTP
      uri.scheme = uri.scheme.gsub(/t/i, 'x')
    when URI::WS, URI::WSS
      uri.scheme = uri.scheme.dup.insert(1, 'x')
    when URI::LDAP, URI::LDAPS
      uri.scheme = uri.scheme.dup.insert(2, 'x')
    when URI::MailTo
      uri.scheme = uri.scheme.dup.insert(4, 'x')
      return uri.to_s.gsub('.', '[.]').gsub('@', '[@]')
    end
    uri.to_s.gsub('.', '[.]')
  end

  # Defang the string in place, if it is an URI, as described for {String#defang_uri}.
  def defang_uri!
    replace(defang_uri)
  end

  # Refang the string if it is an URI.
  # Will refang dot for any scheme and refang scheme as well for supported ones.
  # Supported schemes: HTTP, HTTPS, FTP, WS, WSS, LDAP, LDAPS, Mailto.
  # @return [String] the refanged string if it is an URI or itself else.
  # @example
  #   'hxxp://noraj[.]neverssl[.]com/online/'.refang_uri # => http://noraj.neverssl.com/online/
  def refang_uri
    if %r{://}.match?(self)
      scheme, remains = split('://', 2)
    else
      scheme, remains = split(':', 2)
    end
    case scheme
    when /hxxps?/i, /fxp/i
      scheme.gsub!(/x/i, 't')
    when /wxss?/i, /ldxaps?/i
      scheme.gsub!(/x/i, '')
    when /mailxto/i
      scheme.gsub!(/x/i, '')
      remains.gsub!('[.]', '.')
      remains.gsub!('[@]', '@')
      return scheme.concat(":#{remains}")
    end
    remains.gsub!('[.]', '.')
    if %r{://}.match?(self)
      scheme.concat("://#{remains}")
    else
      scheme.concat(":#{remains}")
    end
  end

  # Refang the string in place, if it is an URI, as described for {String#refang_uri}.
  def refang_uri!
    replace(refang_uri)
  end

  # Defang the string if it is a domain name
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :unvalid Default value: `false`.
  #   If `unvalid: false`, only valid domain name will be defanged.
  #   If `unvalid: true`, everything is defanged.
  # @return [String] the defanged string if it is a valid domain name or itself else.
  # @example
  #   'pwn.by'.defang_domain # => pwn[.]by
  def defang_domain(opts = {})
    opts[:unvalid] ||= false
    if domain? || opts[:unvalid] == true
      gsub('.', '[.]')
    else
      self
    end
  end

  # Defang the string in place, if it is a domain name, as described for {String#defang_domain}.
  def defang_domain!(opts = {})
    replace(defang_domain(opts))
  end

  # Refang the string if it is a domain name
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :unvalid Default value: `false`.
  #   If `unvalid: false`, only valid domain name will be refanged.
  #   If `unvalid: true`, everything is refanged.
  # @return [String] the refanged string if it is a valid domain name or itself else.
  # @example
  #   'pwn[.]by'.refang_domain # => pwn.by
  def refang_domain(opts = {})
    opts[:unvalid] ||= false
    re_domain = gsub('[.]', '.')
    if re_domain.domain? || opts[:unvalid] == true
      re_domain
    else
      self
    end
  end

  # Refang the string in place, if it is a domain name, as described for {String#refang_domain}.
  def refang_domain!(opts = {})
    replace(refang_domain(opts))
  end

  # Defang the string if it is an email address
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :unvalid Default value: `false`.
  #   If `unvalid: false`, only valid email address will be defanged.
  #   If `unvalid: true`, everything is defanged.
  # @return [String] the defanged string if it is an email address or itself else.
  # @example
  #   'noraj.rawsec@pwn.by'.defang_email # => noraj[.]rawsec[@]pwn[.]by
  def defang_email(opts = {})
    opts[:unvalid] ||= false
    if email? || opts[:unvalid] == true
      gsub('.', '[.]').gsub('@', '[@]')
    else
      self
    end
  end

  # Defang the string in place, if it is a email address, as described for {String#defang_email}.
  def defang_email!(opts = {})
    replace(defang_email(opts))
  end

  # Refang the string if it is an email address
  # @param opts [Hash] optional parameters
  # @option opts [Symbol] :unvalid Default value: `false`.
  #   If `unvalid: false`, only valid email address will be refanged.
  #   If `unvalid: true`, everything is refanged.
  # @return [String] the refanged string if it is a valid email address or itself else.
  # @example
  #   'noraj+alias[@]pwn[.]by'.refang_email # => noraj.rawsec@pwn.by
  def refang_email(opts = {})
    opts[:unvalid] ||= false
    re_email = gsub('[.]', '.').gsub('[@]', '@')
    if re_email.email? || opts[:unvalid] == true
      re_email
    else
      self
    end
  end

  # Refang the string in place, if it is a email address, as described for {String#refang_email}.
  def refang_email!(opts = {})
    replace(refang_email(opts))
  end
end
