# frozen_string_literal: true

require 'ipaddr'
require 'uri'

class String
  def defang_ip
    if IPAddr.new(self).ipv4?
      gsub('.', '[.]')
    elsif IPAddr.new(self).ipv6?
      gsub(':', '[:]')
    else
      self
    end
  end

  def defang_uri
    uri = URI(self)
    case uri
    when URI::HTTP, URI::HTTPS, URI::FTP
      uri.scheme = uri.scheme.gsub(/t/i, 'X')
    when URI::WS, URI::WSS
      uri.scheme = uri.scheme.dup.insert(1, 'X')
    when URI::LDAP, URI::LDAPS
      uri.scheme = uri.scheme.dup.insert(2, 'X')
    when URI::MailTo
      uri.scheme = uri.scheme.dup.insert(4, 'X')
    end
    uri.to_s.gsub('.', '[.]')
  end

  def defang_domain
    skip
  end

  def defang_email
    skip
  end
end
