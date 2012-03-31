class ConnectionsGraph
  def initialize(tweetlist)
    @graph = tweetlist.authors.inject({}) do |h, person|
      h.merge(person => tweetlist.mentions_by(person).select { |other|
          tweetlist.mentions_by(other).include?(person)
        })
    end
  end

  def [](person)
    @graph.fetch(person, [])
  end
end
