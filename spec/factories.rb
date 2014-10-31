FactoryGirl.define do 
  
  factory :journal do
    name         "Cars"
    blog_content   "This was a great movie"
  end

  sequence :name do |n|
    "Name-#{n}"
  end

  sequence :email do |n|
    "email-#{n}@email.com"
  end

  factory :user do 
    name     
    email
    password              "foobar"
    password_confirmation "foobar"
  end

end