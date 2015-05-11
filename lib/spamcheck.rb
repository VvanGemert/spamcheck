require 'spamcheck/version'
require 'bayes_motel'
require 'rules/country'

# Spamcheck
module Spamcheck
  module_function

  attr_accessor :settings
  DEFAULT_SETTINGS = {
    store: 'file',
    store_location: 'location_to_file'
  }

  def settings
    return @settings unless @settings.nil?
    DEFAULT_SETTINGS
  end

  def settings=(settings)
    DEFAULT_SETTINGS.merge!(settings)
  end

  def self.mark(namespace, type, message)
    message['country'] = Spamcheck::Rules::Country.check(message['ip'])
    corpse = BayesMotel::Persistence.read(namespace)
    corpse.train(message, type)
    corpse.cleanup
    BayesMotel::Persistence.write(corpse)
  end

  def self.classify(namespace, message)
    corpse = BayesMotel::Persistence.read(namespace)
    corpse.classify(message)
  end
end
