require 'set'

class Tweet
  attr_reader :author, :mentions

  def initialize(tweet)
    if tweet =~ /(\w+): (.*)/
      @author = $1
      @mentions = $2.scan(/@(\w+)/).flatten
    end
  end
end

class ConnectionsGraph
  def initialize(tweets)
    @graph = first_order_connections(mentions_from_tweets(tweets))
  end

  def orders_of_separation(person)
    res = []
    people_so_far = Set.new
    r = [person]
    while true
      people_so_far.merge(r)
      r = their_first_order_connections(r) - people_so_far.to_a
      r.empty? ? break : res << r
    end
    res
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

  def mentions_from_tweets(tweets)
    tweets.inject({}) do |m, tweet|
      m.merge(tweet.author => tweet.mentions)
    end
  end

  def their_first_order_connections(people)
    people.map {|other| @graph[other]}.flatten
  end
end
