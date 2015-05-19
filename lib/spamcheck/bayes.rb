module ClassifierReborn
  # Bayes monkeypatch
  class Bayes
    def export
      { categories: @categories,
        total_words: @total_words,
        category_count: @category_counts,
        category_word_count: @category_word_count }
    end
  end
end
