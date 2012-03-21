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

describe 'Connections' do
  it "should be initialized from empty list of tweets" do
    expect {
      Connections.new([])
    }.should_not raise_error
  end

  describe "#order" do
    it "should take a number and person as arguments" do
      expect {
        Connections.new([]).order(1, 'bob')
      }.should_not raise_error
    end

    describe "first" do
      it "should return empty list for empty connections" do
        Connections.new([]).order(1, 'bob').should == []
      end

      it "should return people that mention each other" do
        t1 = mock(:author => 'bob', :mentions => ['christie'])
        t2 = mock(:author => 'christie', :mentions => ['bob'])
        Connections.new([t1, t2]).order(1, 'bob').should == ['christie']
      end

      it "should not return people that mention someone, but doesn't get mentioned back" do
        t1 = mock(:author => 'bob', :mentions => ['christie'])
        t2 = mock(:author => 'christie', :mentions => ['alberta'])
        Connections.new([t1, t2]).order(1, 'bob').should == []
      end

      it "should return people that mentioned each other many times" do
        t1 = mock(:author => 'alberta', :mentions => ['christie'])
        t2 = mock(:author => 'bob', :mentions => ['christie', 'alberta'])
        t3 = mock(:author => 'christie', :mentions => ['bob', 'alberta'])
        Connections.new([t1, t2, t3]).order(1, 'alberta').should == ['christie']
        Connections.new([t1, t2, t3]).order(1, 'bob').should == ['christie']
        Connections.new([t1, t2, t3]).order(1, 'christie').should == ['alberta', 'bob']
      end
    end
  end
end
