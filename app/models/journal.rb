class Journal < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :blog_contents 

  validates :name, presence: true, length: { in: 3..254 }
  validates :blog_contents, presence: true, length: { in: 3..254 }
  
end
