require_relative '../connections_graph'

describe ConnectionsGraph do
  it "should initialize with array of  tweets" do
    expect {
      ConnectionsGraph.new(mock(:authors => []))
    }.should_not raise_error
  end

  describe "#[]" do
    it "should return [] for no tweets" do
      tweetlist = mock(:authors => [])
      graph = ConnectionsGraph.new(tweetlist)
      graph['bob'].should == []
    end

    it "should return 'bob' as 'alice' connection" do

      tweetlist = mock(:authors => ['alice', 'bob'])
      tweetlist.should_receive(:mentions_by).with('alice').at_least(:once).and_return(['bob'])
      tweetlist.should_receive(:mentions_by).with('bob').at_least(:once).and_return(['alice'])
      graph = ConnectionsGraph.new(tweetlist)
      graph['alice'].should == ['bob']
    end

  end
end
