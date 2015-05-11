require 'JSON'

# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # Country
    module Country
      def self.check(ip)
        country_info = get_country_by_ip(ip)
        country_info['country_code']
      end

      private

      def self.get_country_by_ip(ip)
        url = 'http://www.telize.com/geoip/'
        uri = URI.parse(url + ip.to_s)
        res = Net::HTTP.start(uri.host, uri.port) do |http|
          http.get(uri.request_uri)
        end
        response = res.body
        JSON.parse(response)
      end
    end
  end
end
