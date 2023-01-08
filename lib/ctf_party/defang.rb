# frozen_string_literal: true

require 'ipaddr'
require 'uri'

class String
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
    scheme.concat("://#{remains}")
  end

  def defang_domain(opts = {})
    opts[:unvalid] ||= false
    if domain? || opts[:unvalid] == true
      gsub('.', '[.]')
    else
      self
    end
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

  def defang_email(opts = {})
    opts[:unvalid] ||= false
    if email? || opts[:unvalid] == true
      gsub('.', '[.]').gsub('@', '[@]')
    else
      self
    end
  end

  def refang_email(opts = {})
    opts[:unvalid] ||= false
    re_email = gsub('[.]', '.').gsub('[@]', '@')
    if re_email.domain? || opts[:unvalid] == true
      re_email
    else
      self
    end
  end
end
