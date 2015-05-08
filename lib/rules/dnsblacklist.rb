require 'dnsbl/client'

# Spamcheck
module Spamcheck
  # Rules
  module Rules
    def self.dnsblacklist(ip)
      c = DNSBL::Client.new
      result = c.lookup(ip)
      case result.length
      when 1 then 40
      when 1..2 then 80
      when 2..50 then 100
      else 0
      end
    end
  end
end
