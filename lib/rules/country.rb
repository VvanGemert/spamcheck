require 'JSON'

# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # Country
    module Country
      def self.check(user, _context)
        country_info = get_country_by_ip(user['ip'])
        case country_info['country_code']
        when 'CN' then 10
        when 'UA' then 8
        when 'RU' then 8
        when 'FR' then 4
        else 0
        end
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
