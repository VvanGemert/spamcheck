# Spamcheck
module Spamcheck
  # Rules
  module Rules
    # Links
    module Links
      def self.check(_user, context)
        results = URI.extract(context['content'])
        case results.size
        when 10..50 then 10
        when 8..10 then 8
        when 5..7 then 6
        when 3..4 then 4
        when 1..2 then 3
        else 0
        end
      end
    end
  end
end
