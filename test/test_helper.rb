require 'spamcheck'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'yaml'
require 'forgery'

# Load fixtures
spam = YAML.load_file('test/fixtures/spam.yml')
no_spam = YAML.load_file('test/fixtures/no_spam.yml')
FIXTURES = spam.merge!(no_spam)
