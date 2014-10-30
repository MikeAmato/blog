class Journal < ActiveRecord::Base
  require 'net/https'

  belongs_to :users

  attr_accessible :title, :blog_contents 

  validates :title, presence: true, length: { maximum: 50 }
  validates :blog_contents, presence: true, length: { in: 3..254 }
  
 
end
