require 'JSON'

# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # Stop Forum Spam
    module Stopforumspam
      def self.check(user, _context)
        result = do_request(user['ip'])
        if result['success'] == 1 && result['ip']['appears'] == 1
          50
        else
          0
        end
      end

      private

      def self.do_request(ip)
        uri = URI.parse('http://api.stopforumspam.org/api?f=json&ip=' +
          ip.to_s)
        res = Net::HTTP.start(uri.host, uri.port) do |http|
          http.get(uri.request_uri)
        end
        JSON.parse(res.body)
      end
    end
  end
end
