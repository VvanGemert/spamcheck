require 'socket'

# Spamcheck
module Spamcheck
  # Rules
  module Rules
    def self.ip(ip)
      ipaddr = ip.split('.')
      begin
        hostname = Socket.gethostbyaddr(ipaddr.map(&:to_i).pack('CCCC'))
        ip_by_host = Socket.getaddrinfo(hostname.first, nil)[0][3]
        ip_by_host != ip ? 10 : 0
      rescue SocketError
        8
      end
    end
  end
end
