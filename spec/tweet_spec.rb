require_relative '../tweet'

describe Tweet do
  it "should be initialized with a string" do
    expect {
      Tweet.new('michalkw: hey')
    }.should_not raise_error
  end

  it "should initialize Tweet author" do
    Tweet.new('adam: hello world').author.should == 'adam'
  end

  it "should initialize different Tweet author" do
    Tweet.new('bob: hi there').author.should == 'bob'
  end

  it "should initialize Tweet mention" do
    Tweet.new('bob: hi there @michalkw').mentions.should == ['michalkw']
  end

  it "should initialize different Tweet mention" do
    Tweet.new('bob: hi there @adam').mentions.should == ['adam']
  end

  it "should initialize two Tweet mentions" do
    Tweet.new('bob: hi there @michalkw and @adam').mentions.
      should == ['michalkw', 'adam']
  end

  it "should initialize mentions to empty list when none where found in a Tweet" do
    Tweet.new('bob: about myself').mentions.should == []
  end
end
