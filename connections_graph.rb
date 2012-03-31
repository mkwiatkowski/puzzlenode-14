class ConnectionsGraph
  def initialize(tweetlist)
    @graph = tweetlist.authors.inject({}) do |g, author|
      g.merge(author => tweetlist.mentions_by(author).
        select {|mentioned| tweetlist.mentions_by(mentioned).include?(author)})
    end
  end

  def [](person)
    @graph[person]
  end
end
