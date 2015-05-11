# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # Previous
    module Previous
      def self.check(_user, context)
        time = Time.parse(context['previous_created_at']).to_i
        previous_date = time
        case Time.now.to_i - previous_date.to_i
        when 0..599 then 10
        when 600..1799 then 8
        when 1800..3599 then 6
        when 3600..7199 then 5
        when 7200..432_00 then 2
        else 0
        end
      end
    end
  end
end
