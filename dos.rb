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
    mentions = tweets.inject({}) do |m, tweet|
      m.merge(tweet.author => tweet.mentions)
    end
    @connections = first_order_connections(mentions)
  end

  def order(n, person)
    if n == 1
      @connections[person]
    else
      indirect_connections(n-1, person) - order(n-1, person) - [person]
    end
  end

  private
  def first_order_connections(mentions)
    mentions.keys.inject(Hash.new([])) do |h, author|
      mutual_mentions = mentions[author].select { |other|
        mentions.fetch(other, []).include?(author)
      }.sort
      h.merge(author => mutual_mentions)
    end
  end

  def indirect_connections(n, person)
    @connections[person].map {|other| order(n, other)}.flatten
  end
end
