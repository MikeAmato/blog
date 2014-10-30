class Journal < ActiveRecord::Base
  require 'net/https'

  belongs_to :users

  attr_accessible :name, :blog_contents 

  validates :name, presence: true, length: { maximum: 50 }
  validates :blog_contents, presence: true, length: { in: 3..254 }
  
 
end
