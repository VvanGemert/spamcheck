require 'spamcheck/version'

# Spamcheck
module Spamcheck
  module_function
  attr_accessor :settings
  DEFAULT_SETTINGS = {
    spam_score: 40,
    disabled_rules: []
  }

  def settings
    return @settings unless @settings.nil?
    DEFAULT_SETTINGS
  end

  def settings=(settings)
    DEFAULT_SETTINGS.merge!(settings)
  end

  def self.check(user, context = {})
    score = {}
    require_rules.each do |r|
      score[r.to_sym] =
        get_module('Spamcheck::Rules::' + r.capitalize)
        .check(user, context)
    end
    count_total_and_classify(score)
  end

  private

  def self.get_module(str)
    str.split('::').reduce(Object) do |mod, class_name|
      mod.const_get(class_name)
    end
  end

  def self.require_rules
    list = []
    Dir[File.dirname(__FILE__) + '/rules/*.rb'].each do |file|
      list.push(file.split('/').last[0..-4])
      require file
    end
    list - settings[:disabled_rules]
  end

  def self.count_total_and_classify(score)
    score[:total] = score.values.map(&:to_i).reduce(:+)
    spam_score = settings[:spam_score].to_i - 1
    score[:spam] = score[:total] > spam_score ? true : false
    score
  end
end
