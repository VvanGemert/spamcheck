# Spamcheck

Spamcheck is a simple gem which checks users and forum posts, comments and such for spam. 
It uses a Bayes like filtering system which can be configured to tailor your needs.

#### The spam filter can take some time to process, I suggest adding the check to background job!

The following checks are performed and awarded points accordingly:

- DNS blacklist with RBL
- Location of user (by IP)
- Stopforumspam.com check
- IP for fake hostname
- Email domain and extension
- Number of links in message
- Number of messages for the user
- The date when the last message was created
- The date when the user was created

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spamcheck'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spamcheck

## Settings

You can add the following code to a initializer or add it your worker:
```ruby
## Example
Spamcheck.settings = { spam_score: 40, disabled_rules: ['stopforumspam', 'dnsblacklist', 'country'] }
```

## Usage

You can use the gem with the following line:
```ruby

user = { 
  'ip' => '{ ip address }',
  'email' => '{ email }',
  'created_at' => '{ date time}',
  'username' => '{ username }' }

context = {
  'title' => '{ Title }',
  'content' => '{ message }',
  'previous_created_at' => '{ date time}',
  'message_count' => '{ number }' }

Spamcheck.check(user, context)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/spamcheck/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
