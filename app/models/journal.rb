class Journal < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :blog_contents 

  validates :name, presence: true, length: { in: 3..254 }
  validates :blog_contents, presence: true, length: { in: 3..254 }
  

  def get_twitter_posts
    posts = HTTParty.get "https://api.twitter.com/1.1/search/tweets.json?q=%40twitterapi&count=5"
  
    
  end
end
