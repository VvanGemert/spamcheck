# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # Created
    module Created
      def self.check(user, _context)
        time = Time.parse(user['created_at']).to_i
        case Time.now.to_i - time
        when 0..599 then 10
        when 600..1799 then 8
        when 1800..3599 then 6
        when 3600..7199 then 5
        when 7200..432_00 then 3
        else 0
        end
      end
    end
  end
end
