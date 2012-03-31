class Tweet
  attr_reader :author, :mentions

  def initialize(str)
    str =~ /(.*):(.*)/
    @author = $1
    @mentions = $2.scan(/@(\w+)/).flatten
  end
end
