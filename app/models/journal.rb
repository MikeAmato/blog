class Journal < ActiveRecord::Base

  belongs_to :users

  attr_accessible :title, :blog_contents 

  validates :title, presence: true, length: { maximum: 50 }
  validates :blog_contents, presence: true, length: { in: 3..254 }
  
  def self.get_tweets(search)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "C56CClz65LWoyXrAniUkLV5iX"
      config.consumer_secret = "A6aWqbd38JcoKzolVRhTuIRGpUpXernsLQSG4kkCsJRNBhLcX1"
      config.access_token = "2821495600-w3IN3lP4eoglXto3OAnRzqwuE5GfubBg7pnYxKg"
      config.access_token_secret = "g7Ub2fl4BYZovJxvaaWvsSySd1NmaeWns8vmq6ITBz77N"
    end

    client.search("#{search}", :count => 5).each do |tweet| 
      tweet = "#{tweet.user.name} (@#{tweet.user.screen_name}): #{tweet.text}"
    end
  end
end
