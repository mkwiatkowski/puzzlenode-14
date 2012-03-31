class TweetList
  def initialize(tweets)
    @tweets_mentions = tweets.inject({}) do |h, t|
      h.merge(t.author => t.mentions)
    end
  end

  def authors
    @tweets_mentions.keys
  end

  def mentions_of(author)
    @tweets_mentions.fetch(author, [])
  end
end
