# frozen_string_literal: true

module ClassifierReborn
  # Bayes monkeypatch
  class Bayes
    def export
      { categories: @categories,
        total_words: @total_words,
        category_counts: @category_counts,
        category_word_count: @category_word_count }
    end

    def import(data)
      @categories = data[:categories]
      @total_words = data[:total_words]
      @category_counts = data[:category_counts]
      @category_word_count = data[:category_word_count]
      true
    end
  end
end
