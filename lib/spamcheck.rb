require 'spamcheck/version'
require 'rules/country'
require 'rules/ip'
require 'rules/stopforumspam'
require 'rules/email'
require 'rules/created'
require 'rules/links'
require 'rules/previous'
require 'rules/message_count'
require 'rules/dnsblacklist'

# Spamcheck
module Spamcheck
  def self.check(user, context = nil)
    @country = Spamcheck::Rules.country(user[:ip]).to_s
    @ip = Spamcheck::Rules.ip(user[:ip]).to_s
    @sfs = Spamcheck::Rules.stopforumspam(user[:ip]).to_s
    @email = Spamcheck::Rules.email(user[:email]).to_s
    @created = Spamcheck::Rules.created(user[:created_at]).to_s
    @dnsblacklist = Spamcheck::Rules.dnsblacklist(user[:ip]).to_s
    unless context.nil?
      @links = Spamcheck::Rules.links(context).to_s
      @previous = Spamcheck::Rules.previous(context).to_s
      @message_count = Spamcheck::Rules.message_count(context).to_s
    end
    # show_totals
    { score: count_score, tests:
      {
        country: @country,
        ip: @ip,
        sfs: @sfs,
        email: @email,
        created: @created,
        dnsblacklist: @dnsblacklist,
        links: @links,
        previous: @previous,
        message_count: @message_count
      }
    }
  end

  def self.count_score
    (@country.to_i +
     @ip.to_i +
     @sfs.to_i +
     @email.to_i +
     @created.to_i +
     @dnsblacklist.to_i +
     @links.to_i +
     @previous.to_i +
     @message_count.to_i).to_i
  end

  def self.show_totals
    p 'Country: ' + @country
    p 'IP check: ' + @ip
    p 'SFS: ' + @sfs
    p 'Email: ' + @email
    p 'Created: ' + @created
    p 'Total: ' +
      (@country.to_i +
       @ip.to_i +
       @sfs.to_i +
       @email.to_i +
       @created.to_i).to_i.to_s
  end
end
