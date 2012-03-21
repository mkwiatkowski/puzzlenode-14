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
    @map = tweets.inject(Hash.new([])) do |map, tweet|
      map[tweet.author] = tweet.mentions
      map
    end
  end

  def first_order(person)
    @map[person].select do |other_person|
      @map[other_person].include?(person)
    end.sort
  end
end
