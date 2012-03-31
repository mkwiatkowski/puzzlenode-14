
require_relative '../tweetlist'

describe TweetList do
  it "should be initialized with []" do
    expect {
      TweetList.new([])
    }.should_not raise_error
  end

  describe "#authors" do
    it "should return array of authors" do
      t1 = mock(:author => 'bob', :mentions => [])
      t2 = mock(:author => 'alice', :mentions => [])
      TweetList.new([t1, t2]).authors.
        should == ['bob', 'alice']
    end
  end

  describe "#mentions_by" do
    it "should return array of people"do
      t = mock(:author => 'bob', :mentions => ['alice'])
      TweetList.new([t]).mentions_by('bob').
        should == ['alice']
    end

    it "should return array without duplicates"do
      t1 = mock(:author => 'bob', :mentions => ['alice'])
      t2 = mock(:author => 'bob', :mentions => ['alice', 'celes'])
      TweetList.new([t1, t2]).mentions_by('bob').
        should == ['alice', 'celes']
    end

    10000.times do |i|
      it "should disregard tweets order #{i}" do
        t1 = mock(:author => 'bob', :mentions => ['alice', 'celes'])
        t2 = mock(:author => 'bob', :mentions => ['alice'])
        TweetList.new([t1, t2]).mentions_by('bob').
          should == ['alice', 'celes']
      end
    end
  end
end
