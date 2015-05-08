# Spamcheck
module Spamcheck
  # Rules
  module Rules
    def self.email(email)
      domain = email.split('@').last
      ext = domain.split('.').last
      points_extension(ext) +
        points_domain(domain)
    end

    def self.points_extension(ext)
      case ext.downcase
      when 'cn' then 10
      when 'ds' then 8
      when 'ru' then 8
      when 'in' then 5
      else 0
      end
    end

    def self.points_domain(domain)
      case domain.downcase
      when 'gmail.com' then 8
      when 'yahoo.com' then 8
      when 'outlook.com' then 5
      when 'hotmail.com' then 5
      when 'mailn.pl' then 20
      else 0
      end
    end
  end
end
