require_relative '../tweet'

describe Tweet do
  it "should intialize with string" do
    expect {
      Tweet.new('bob: hello')
    }.should_not raise_error
  end

  describe "#author" do
    it "should return author of tweet" do
      tweet = Tweet.new('bob: hello')
      tweet.author.should == 'bob'
    end

    it "should return author of another tweet" do
      tweet = Tweet.new('michalkw: heelo')
      tweet.author.should == 'michalkw'
    end
  end

  describe "#mentions" do
    it "should return mentions of tweet" do
      tweet = Tweet.new('michalkw: hello @seban')
      tweet.mentions.should == ['seban']
    end

    it "should return mentions of another tweet" do
      tweet = Tweet.new('seban: hello @michalkw')
      tweet.mentions.should == ['michalkw']
    end
  end
end
