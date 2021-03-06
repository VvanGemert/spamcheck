# frozen_string_literal: true

require 'dnsbl/client'

# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # DNSBlacklist
    module Dnsblacklist
      def self.check(user, _context)
        c = DNSBL::Client.new
        result = c.lookup(user['ip'])
        case result.length
        when 1 then 30
        when 1..2 then 40
        when 2..50 then 50
        else 0
        end
      end
    end
  end
end
