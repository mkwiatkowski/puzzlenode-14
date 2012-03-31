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

class TweetList
  attr_reader :first_order_connections

  def initialize(tweets)
    @first_order_connections = connections_graph(mentions_from_tweets(tweets))
  end

  private
  def connections_graph(mentions)
    mentions.keys.inject(Hash.new([])) do |h, author|
      mutual_mentions = mentions[author].select { |other|
        mentions.fetch(other, []).include?(author)
      }.sort
      h.merge(author => mutual_mentions)
    end
  end

  def mentions_from_tweets(tweets)
    tweets.inject(Hash.new {[]}) do |m, tweet|
      m[tweet.author] = (m[tweet.author] + tweet.mentions).uniq
      m
    end
  end
end

class ConnectionsGraph
  def initialize(connections)
    @connections = connections
  end

  def authors
    @connections.keys
  end

  def degrees_of_separation(person)
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
  def their_first_order_connections(people)
    people.map {|other| @connections[other]}.compact.flatten
  end
end

def main
  tweets = File.open(ARGV[0]).readlines.map { |t| Tweet.new(t) }
  tweetlist = TweetList.new(tweets)
  graph = ConnectionsGraph.new(tweetlist.first_order_connections)
  graph.authors.sort.each do |author|
    puts author
    graph.degrees_of_separation(author).each do |people|
      puts(people.uniq.sort.join(', '))
    end
    puts
  end
end

if __FILE__ == $0
  main
end
