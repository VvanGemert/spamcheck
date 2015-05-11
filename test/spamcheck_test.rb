require 'test_helper'

# SpamcheckTest
class SpamcheckTest < Minitest::Test
  def test_simple_spam_message
    FIXTURES['spam'].each do |msg|
      user = msg['message']['user']
      context = msg['message']['context']
      result = Spamcheck.check(user, context)
      assert_equal true, result[:spam]
    end
  end

  def test_simple_non_spam_message
    FIXTURES['no_spam'].each do |msg|
      user = msg['message']['user']
      context = msg['message']['context']
      result = Spamcheck.check(user, context)
      assert_equal false, result[:spam]
    end
  end
end
