require_relative '../dos'

describe DegreesOfSeparation do
  let(:dos) { DegreesOfSeparation.new }

  describe "#connections_from_tweet" do
    it "should return connections from tweet" do
      tweet = "alberta: hey @christie. what will we be reading at the book club meeting tonight?"
      dos.connections_from_tweet(tweet).should == {'alberta' => ['christie']}
    end
  end
end
