require 'spamcheck/version'

# Spamcheck
module Spamcheck
  def self.check(user, context = {})
    score = {}
    rules = require_rules
    rules.each do |r|
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
    list
  end

  def self.count_total_and_classify(score)
    score[:total] = score.values.map(&:to_i).reduce(:+)
    score[:spam] = score[:total] > 39 ? true : false
    score
  end
end
