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
    map = tweets.inject(Hash.new([])) do |m, tweet|
      m[tweet.author] = tweet.mentions
      m
    end
    @connections = tweets.map(&:author).inject(Hash.new([])) do |h, author|
      conn = map[author].select { |other_person|
        map[other_person].include?(author)
      }.sort
      h[author] = conn
      h
    end
  end

  def order(n, person)
    @connections[person]
  end
end
