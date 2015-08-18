require 'test_helper'

# SpamcheckTest
class SpamcheckTest < Minitest::Test
  def setup
    Spamcheck.clear
  end

  def test_simple_spam_message
    Spamcheck.clear
    Spamcheck.mark(:spam, 'This is a spammy text.')
    Spamcheck.mark(:ham, 'This is a normal text.')

    assert_equal true, Spamcheck.spam?('spammy text this is.')
    assert_equal false, Spamcheck.spam?('this is pretty normal.')
  end

  def test_lorem_ipsum
    Spamcheck.clear

    spamline = 'spam spam spam.'
    Spamcheck.mark(:spam, spamline)
    Spamcheck.mark(:spam, spamline)
    Spamcheck.mark(:spam, spamline)

    50.times do |i|
      line = Forgery(:lorem_ipsum).sentence(random: true)
      Spamcheck.mark(:ham, line)
    end
    line = Forgery(:lorem_ipsum).sentence(random: true)
    assert_equal false, Spamcheck.spam?(line)
  end
end
