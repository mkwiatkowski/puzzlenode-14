class Tweet
  attr_reader :author, :mentions

  def initialize(tweet)
    if tweet =~ /(\w+): (.*)/
      @author = $1
      @mentions = $2.scan(/@(\w+)/).flatten
    end
  end
end

class Connections
  def initialize(tweets)
    initialize_authors_mentions_from_tweets(tweets)
    @connections = tweets.map(&:author).inject(Hash.new([])) do |h, author|
      h.merge(author => mutual_mentions(author))
    end
  end

  def order(n, person)
    @connections[person]
  end

  private
  def initialize_authors_mentions_from_tweets(tweets)
    @authors_mentions = tweets.inject({}) do |m, tweet|
      m[tweet.author] = tweet.mentions
      m
    end
  end

  def mutual_mentions(person)
    @authors_mentions[person].select { |other_person|
      @authors_mentions.fetch(other_person, []).include?(person)
    }.sort
  end
end
