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

    it "should return connections from tweets with two mentions" do
      tweet = 'christie: "Every day, men and women, conversing, beholding and beholden..." /cc @alberta, @bob'
      dos.connections_from_tweet(tweet).should == {'christie' => ['alberta', 'bob']}
    end
  end
end
