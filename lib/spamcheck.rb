# frozen_string_literal: true

require 'spamcheck/version'
require 'spamcheck/classifier'
require 'rules/country'
require 'rules/dnsblacklist'

# Spamcheck
module Spamcheck
  module_function

  DEFAULT_SETTINGS = {
    storage: 'disk',
    store_location: 'spamcheck.dat'
  }.freeze

  def settings
    @settings ||= DEFAULT_SETTINGS
  end

  def settings=(settings)
    @settings = DEFAULT_SETTINGS.merge!(settings)
  end

  def self.mark(type, text)
    classifier = load_classifier
    classifier.mark(type, text)
    store_classifier(classifier)
  end

  def self.spam?(text)
    classifier = load_classifier
    classifier.classify(text) == 'Spam'
  end

  def self.export
    classifier = load_classifier
    classifier.export
  end

  def self.import(data)
    classifier = load_classifier
    classifier.import(data)
    store_classifier(classifier)
    true
  end

  def self.clear
    persistence
    @store.clear
  end

  def self.persistence
    store = settings[:storage]
    require 'storage/' + store
    @store = Object.const_get('Storage')
                   .const_get(store.capitalize).new(settings)
  end

  def self.store_classifier(classifier)
    persistence
    @classifier = @store.save(classifier)
  end

  def self.load_classifier
    persistence
    @classifier = @store.retrieve
  end
end
