class Journal < ActiveRecord::Base
  belongs_to :user

  attr_accessible :title, :blog_contents 

  validates :title, presence: true, length: { maximum: 50 }
  validates :blog_contents, presence: true, length: { in: 3..254 }
  

  def get_twitter_posts
    posts = HTTParty.get "https://api.twitter.com/1.1/search/tweets.json?q=%40twitterapi&count=5"
  end
end
