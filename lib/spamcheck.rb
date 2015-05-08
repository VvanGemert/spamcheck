require 'spamcheck/version'
require 'rules/country'
require 'rules/ip'
require 'rules/stopforumspam'

# Spamcheck
module Spamcheck
  def self.check(data)
    # Spamcheck::Rules.country(data[:ip])
    # Spamcheck::Rules.ip(data[:ip])
    Spamcheck::Rules.stopforumspam(data[:ip])
  end
end
