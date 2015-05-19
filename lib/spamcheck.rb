require 'spamcheck/version'
require 'spamcheck/classifier'
require 'rules/country'
require 'rules/dnsblacklist'

# Spamcheck
module Spamcheck
  module_function

  attr_accessor :settings
  DEFAULT_SETTINGS = {
    storage: 'disk',
    store_location: 'spamcheck.dat'
  }

  def settings
    return @settings unless @settings.nil?
    DEFAULT_SETTINGS
  end

  def settings=(settings)
    DEFAULT_SETTINGS.merge!(settings)
  end

  def self.mark(type, text)
    classifier = load_classifier
    classifier.mark(type, text)
    store_classifier(classifier)
  end

  def self.spam?(text)
    classifier = load_classifier
    classifier.classify(text)
  end

  def self.export
    classifier = load_classifier
    classifier.export
  end

  private

  def self.persistence
    return @store if @store
    if settings[:storage] == 'disk'
      require 'storage/disk'
      @store = Storage::Disk.new(settings)
    end
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
