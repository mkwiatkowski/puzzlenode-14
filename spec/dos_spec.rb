require_relative '../dos'

describe Tweet do
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

describe Connections do
  it "should be initialized from empty list of tweets" do
    Connections.new([])
  end
end
