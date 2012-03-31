
class TweetList
  def initialize(tweets)
    @tweets = tweets.inject(Hash.new{ []}) do |h, t|
      h[t.author] = (h[t.author] + t.mentions).uniq
      h
    end
  end

  def authors
    @tweets.keys
  end

  def mentions_by(person)
    @tweets[person]
  end
end

