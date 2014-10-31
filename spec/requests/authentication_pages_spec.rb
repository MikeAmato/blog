require 'rails_helper'

describe "Authentication", :type => :request do

subject { page }
  describe "signin page" do
    before {visit signin_path }

    it { should have_title("Blog | Sign In") }
    it { should have_selector('h1', text: "Sign In") }

    describe "signin POST /sessions" do 
        before do
          User.destroy_all
          @user = User.FactoryGirl.create(:user)
        end 

        context "valid info" do
          fill_in "Email", with: @user.email
          fill_in "Password", with: @user.password
          click_button "Sign In"
        end

        it { should have_link('Profile', href: user_path(@user)) }
        it { should_not have_link('Sign In', href: signin_path) }
        it { should_not have_link('Sign Up', href: signup_path)}
        #once we sign in with good stuff
        #we see links that are only appllicable to signed in users
        #Has: profile, Sign Out 
        #Doesn't have: Sign in, Sign Up
      end

      context "invalid info" do 
        before do 
          click_button "Sign In"
        end
        
        it { should_not have_link('Profile', href: user_path(@user)) }
        it { should have_link('Sign In', href: signin_path) }
        it { should have_link('Sign Up', href: signup_path)}

        #it doesn't have : profile, Settings, Sign Out 
        #Has: Sign In, Sign Up
      end 
    end
  end
end




 # describe "GET /authentication_pages" do
  #   it "works! (now write some real specs)" do
  #     get authentication_pages_index_path
  #     expect(response).to have_http_status(200)
  #   end
  # end