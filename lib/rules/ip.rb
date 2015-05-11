require 'socket'

# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # Ip
    module Ip
      def self.check(user, _context)
        ipaddr = user['ip'].split('.')
        begin
          hostname = Socket.gethostbyaddr(ipaddr.map(&:to_i).pack('CCCC'))
          ip_by_host = Socket.getaddrinfo(hostname.first, nil)[0][3]
          ip_by_host != user['ip'] ? 5 : 0
        rescue SocketError
          8
        end
      end
    end
  end
end
