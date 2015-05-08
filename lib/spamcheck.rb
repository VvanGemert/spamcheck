require 'spamcheck/version'
require 'rules/country'

# Spamcheck
module Spamcheck
  def self.check(data)
    Spamcheck::Rules.country(data[:ip])
  end
end
