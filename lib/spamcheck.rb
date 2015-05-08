require 'spamcheck/version'
require 'rules/country'
require 'rules/ip'

# Spamcheck
module Spamcheck
  def self.check(data)
    # Spamcheck::Rules.country(data[:ip])
    Spamcheck::Rules.ip(data[:ip])
  end
end
