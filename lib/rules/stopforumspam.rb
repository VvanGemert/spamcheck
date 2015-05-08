require 'JSON'

# Spamcheck
module Spamcheck
  # Rules
  module Rules
    def self.stopforumspam(ip)
      uri = URI.parse('http://api.stopforumspam.org/api?f=json&ip=' + ip.to_s)
      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.get(uri.request_uri)
      end
      response = res.body
      result = JSON.parse(response)

      if result['success'] == 1 && result['ip']['appears'] == 1
        50
      else
        0
      end
    end
  end
end
