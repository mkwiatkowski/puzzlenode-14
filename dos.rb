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
    @authors_mentions = authors_mentions_from_tweets(tweets)
    @connections = tweets.map(&:author).inject(Hash.new([])) do |h, author|
      conn = @authors_mentions[author].select { |other_person|
        @authors_mentions.fetch(other_person, []).include?(author)
      }.sort
      h[author] = conn
      h
    end
  end

  def order(n, person)
    @connections[person]
  end

  private
  def authors_mentions_from_tweets(tweets)
    tweets.inject({}) do |m, tweet|
      m[tweet.author] = tweet.mentions
      m
    end
  end
end
