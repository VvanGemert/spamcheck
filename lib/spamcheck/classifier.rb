# frozen_string_literal: true

require 'classifier-reborn'
require 'spamcheck/bayes'

module Spamcheck
  # Classifier
  class Classifier
    def initialize
      @classifier = ClassifierReborn::Bayes.new('ham', 'spam')
    end

    def classify(text)
      @classifier.classify(text)
    end

    def mark(type, text)
      if type.to_sym == :spam
        @classifier.train_spam(text)
      else
        @classifier.train_ham(text)
      end
    end

    def export
      @classifier.export
    end

    def import(data)
      @classifier.import(data)
    end

    def classifications(text)
      @classifier.classifications(text)
    end
  end
end
