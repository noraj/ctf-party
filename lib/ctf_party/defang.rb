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

  def refang_ip!(opts = {})
    replace(refang_ip(opts))
  end

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

  def defang_uri!
    replace(defang_uri)
  end

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

  def refang_uri!
    replace(refang_uri)
  end

  def defang_domain(opts = {})
    opts[:unvalid] ||= false
    if domain? || opts[:unvalid] == true
      gsub('.', '[.]')
    else
      self
    end
  end

  def defang_domain!(opts = {})
    replace(defang_domain(opts))
  end

  def refang_domain(opts = {})
    opts[:unvalid] ||= false
    re_domain = gsub('[.]', '.')
    if re_domain.domain? || opts[:unvalid] == true
      re_domain
    else
      self
    end
  end

  def refang_domain!(opts = {})
    replace(refang_domain(opts))
  end

  def defang_email(opts = {})
    opts[:unvalid] ||= false
    if email? || opts[:unvalid] == true
      gsub('.', '[.]').gsub('@', '[@]')
    else
      self
    end
  end

  def defang_email!(opts = {})
    replace(defang_email(opts))
  end

  def refang_email(opts = {})
    opts[:unvalid] ||= false
    re_email = gsub('[.]', '.').gsub('[@]', '@')
    if re_email.email? || opts[:unvalid] == true
      re_email
    else
      self
    end
  end

  def refang_email!(opts = {})
    replace(refang_email(opts))
  end
end
