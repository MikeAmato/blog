class Journal < ActiveRecord::Base
  require 'twitter'

  belongs_to :users

  attr_accessible :title, :blog_contents 

  validates :title, presence: true, length: { maximum: 50 }
  validates :blog_contents, presence: true, length: { in: 3..254 }
  
  def get_tweets(search)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "C56CClz65LWoyXrAniUkLV5iX"
      config.consumer_secret = "A6aWqbd38JcoKzolVRhTuIRGpUpXernsLQSG4kkCsJRNBhLcX1"
    end

    client.search("#{search}", :count => 5).each do |tweet| 
      puts "#{tweet.user.name} (@#{tweet.user.screen_name}): #{tweet.text}"
    end
  end

end
