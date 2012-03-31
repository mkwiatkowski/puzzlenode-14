require_relative '../connections_graph'

describe ConnectionsGraph do
  it "should be initialized with list of tweets" do
    expect {
      tl = mock(:authors => [])
      ConnectionsGraph.new(tl)
    }.should_not raise_error
  end

  describe "#[]" do
    it "should return connections of a person" do
      tl = mock(:authors => ['bob', 'cecil'])
      tl.should_receive(:mentions_by).with('bob').at_least(:once).
        and_return(['cecil'])
      tl.should_receive(:mentions_by).with('cecil').at_least(:once).
        and_return(['bob'])
      graph = ConnectionsGraph.new(tl)
      graph['bob'].should == ['cecil']
      graph['cecil'].should == ['bob']
    end

    it "should not treat one way mention as a connection" do
      tl = mock(:authors => ['bob'])
      tl.should_receive(:mentions_by).with('bob').at_least(:once).
        and_return(['cecil'])
      tl.should_receive(:mentions_by).with('cecil').and_return([])
      graph = ConnectionsGraph.new(tl)
      graph['bob'].should == []
    end
  end
end
