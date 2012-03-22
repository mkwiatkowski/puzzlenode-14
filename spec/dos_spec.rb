require_relative '../dos'

describe 'Tweet' do
  let(:one_mention_tweet) { "alberta: hey @christie. what will we be reading at the book club meeting tonight?" }
  let(:zero_mentions_tweet) { "bob: They impress us ever with the conviction that one nature wrote and the same reads." }
  let(:two_mentions_tweet) { 'christie: "Every day, men and women, conversing, beholding and beholden..." /cc @alberta, @bob' }

  it "should be initialized from string" do
    expect {
      Tweet.new(one_mention_tweet)
    }.should_not raise_error
  end

  it "should extract author from the tweet" do
    tweet = Tweet.new(one_mention_tweet)
    tweet.author.should == 'alberta'
  end

  it "should extract single mention from the tweet" do
    tweet = Tweet.new(one_mention_tweet)
    tweet.mentions.should == ['christie']
  end

  it "should extract author from tweet with no mentions" do
    tweet = Tweet.new(zero_mentions_tweet)
    tweet.author.should == 'bob'
  end

  it "should return empty list when no mentions were present" do
    tweet = Tweet.new(zero_mentions_tweet)
    tweet.mentions.should == []
  end

  it "should return both mentions from tweet with two mentions" do
    tweet = Tweet.new(two_mentions_tweet)
    tweet.mentions.should == ['alberta', 'bob']
  end
end

describe 'TweetList' do
  it "should be initialized from empty list of tweets" do
    expect {
      TweetList.new([])
    }.should_not raise_error
  end

  describe "#first_order_connections" do
    it "should return empty hash for empty list" do
      TweetList.new([]).first_order_connections.should == {}
    end

    it "should not return people that mention someone, but doesn't get mentioned back" do
      t1 = mock(:author => 'bob', :mentions => ['christie'])
      t2 = mock(:author => 'christie', :mentions => ['alberta'])
      TweetList.new([t1, t2]).first_order_connections.should ==
        {'bob' => [], 'christie' => []}
    end

    it "should return people that mention each other" do
      t1 = mock(:author => 'bob', :mentions => ['christie'])
      t2 = mock(:author => 'christie', :mentions => ['bob'])
      TweetList.new([t1, t2]).first_order_connections.should ==
        {'bob' => ['christie'], 'christie' => ['bob']}
    end

    it "should return people that mentioned each other many times" do
      t1 = mock(:author => 'alberta', :mentions => ['christie'])
      t2 = mock(:author => 'bob', :mentions => ['christie', 'alberta'])
      t3 = mock(:author => 'christie', :mentions => ['bob', 'alberta'])
      TweetList.new([t1, t2, t3]).first_order_connections.should ==
        {'alberta' => ['christie'], 'bob' => ['christie'], 'christie' => ['alberta', 'bob']}
    end

    it "should return merged connections from multiple tweets of the same author" do
      t1 = mock(:author => 'bob', :mentions => ['alberta'])
      t2 = mock(:author => 'bob', :mentions => ['alberta', 'christie'])
      t3 = mock(:author => 'alberta', :mentions => ['bob'])
      t4 = mock(:author => 'christie', :mentions => ['bob'])
      TweetList.new([t1, t2, t3, t4]).first_order_connections.should ==
        {'bob' => ['alberta', 'christie'], 'alberta' => ['bob'], 'christie' => ['bob']}
    end
  end
end

describe 'ConnectionsGraph' do
  it "should be initialized from empty list of tweets" do
    expect {
      ConnectionsGraph.new([])
    }.should_not raise_error
  end

  describe "#orders" do
    it "should return empty list for empty connections" do
      ConnectionsGraph.new({}).degrees_of_separation('bob').should == []
    end

    it "should return people that are connected" do
      graph = {'bob' => 'christie', 'christie' => 'bob'}
      ConnectionsGraph.new(graph).degrees_of_separation('bob').should == [['christie']]
    end

    it "should return all orders of separation for a given person" do
      graph = {'alberta' => ['christie'], 'bob' => ['christie', 'donald'],
        'christie' => ['bob', 'alberta'], 'donald' => ['bob']}
      ConnectionsGraph.new(graph).degrees_of_separation('alberta').should ==
        [['christie'], ['bob'], ['donald']]
    end

    it "should return only first order connections if there are all there is for a user" do
      graph = {'alberta' => ['christie'], 'bob' => ['donald'],
        'christie' => ['alberta'], 'donald' => ['bob']}
      ConnectionsGraph.new(graph).degrees_of_separation('alberta').should ==
        [['christie']]
    end
  end
end
