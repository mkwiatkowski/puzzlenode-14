require_relative '../dos'

describe DegreesOfSeparation do
  let(:dos) { DegreesOfSeparation.new }

  describe "#connections_from_tweet" do
    it "should return connections from tweet with one mention" do
      tweet = "alberta: hey @christie. what will we be reading at the book club meeting tonight?"
      dos.connections_from_tweet(tweet).should == {'alberta' => ['christie']}
    end

    it "should return connections from tweet with no mentions" do
      tweet = "bob: They impress us ever with the conviction that one nature wrote and the same reads."
      dos.connections_from_tweet(tweet).should == {}
    end
  end
end
