class DegreesOfSeparation
  def connections_from_tweet(tweet)
    if tweet =~ /(\w+): (.*@.*)/
      { $1 => $2.scan(/@(\w+)/).flatten }
    else
      {}
    end
  end
end

class Tweet
  attr_reader :author, :mentions

  def initialize(tweet)
    if tweet =~ /(\w+): (.*)/
      @author = $1
      @mentions = $2.scan(/@(\w+)/).flatten
    end
  end
end
