class DegreesOfSeparation
  def connections_from_tweet(tweet)
    if tweet =~ /(\w+): .*@(\w+)/
      { $1 => [$2] }
    else
      {}
    end
  end
end
