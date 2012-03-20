class DegreesOfSeparation
  def connections_from_tweet(tweet)
    if tweet =~ /(\w+): (.*@.*)/
      { $1 => $2.scan(/@(\w+)/).flatten }
    else
      {}
    end
  end
end
