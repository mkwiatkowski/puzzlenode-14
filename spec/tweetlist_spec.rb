require_relative '../tweetlist'

describe TweetList do
  it "should be initialized with Array of Tweets" do
    expect {
      TweetList.new([])
    }.should_not raise_error
  end

  describe "#authors" do
    it "should return empty Array for empty Tweet list" do
      TweetList.new([]).authors.should == []
    end

    it "should return all authors of passed Tweets" do
      t1 = mock(:author => 'bob', :mentions => [])
      t2 = mock(:author => 'cecil', :mentions => [])
      TweetList.new([t1, t2]).authors.should == ['bob', 'cecil']
    end

    it "should merge mentions of authors from multiple tweets"
  end

  describe "#mentions_of" do
    it "should return empty Array for existing author without mentions" do
      t = mock(:author => 'bob', :mentions => [])
      TweetList.new([t]).mentions_of('bob').should == []
    end

    it "should return empty Array for non-existing author" do
      TweetList.new([]).mentions_of('michal').should == []
    end

    it "should return a sorted list"
    it "should not return duplicates"
  end
end
