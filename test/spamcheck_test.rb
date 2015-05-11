require 'minitest/autorun'
require 'spamcheck'

# SpamcheckTest
class SpamcheckTest < Minitest::Test
  def test_simple_spam_message
    user = {
      ip: '103.21.43.46',
      email: 'lucccy153@hotmail.com',
      created_at: Time.at(Time.now.to_i - 1200) }

    context = {
      message: 'This is a test <a href="http://www.google.nl"></a>',
      previous_created_at: Time.at(Time.now.to_i - 300),
      message_count: 5 }

    result = Spamcheck.check(user, context)
    assert_equal 126, result[:total]
  end

  def test_simple_non_spam_message
    user = {
      ip: '89.98.54.102',
      email: 'vincent@revelus.nl',
      created_at: Time.at(Time.now.to_i - 480_00) }

    context = {
      message: 'This is a normal message',
      previous_created_at: Time.at(Time.now.to_i - 480_00),
      message_count: 40 }

    result = Spamcheck.check(user, context)
    assert_equal 0, result[:total]
  end
end
