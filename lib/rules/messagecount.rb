# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # Messagecount
    module Messagecount
      def self.check(_user, context)
        case context[:message_count].to_i
        when 0 then 10
        when 1..2 then 4
        when 3..10 then 2
        when 11..20 then 1
        else 0
        end
      end
    end
  end
end
