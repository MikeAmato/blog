require 'spec_helper'

describe "users" do
  
  subject { page }
  
  describe "signup page GET /signup" do
    before { visit signup_path }

    it { should have_title("Blog | Sign Up") }
    it { should have_selector('h1', text: "Sign Up") }

    describe "signup POST /users" do 
      let(:submit) { "Done"} 

      context "valid info" do 
        before do
          fill_in "Name", with: "John Smith"
          fill_in "Email", with: "jsmith@gmail.com"
          fill_in "Password", with: "foobar"
          fill_in "Password confirmation", with: "foobar"
        end

        it "creates user"

        describe "after submission" do 
          before { click_button submit }

          it { should have_title("Blog | John") }
          it { should have_selector('h1', text: "John") }
        end
      end 

      context "invalid info" do 
        it "does not create user" do 
          expect { click_button submit }.not_to change(User, :count)
        end

        describe "after submission" do 
          before { click_button submit}

          it {should have_title('Blog | Sign Up') }
          it { should have_content('error')}
        end   
      end 
    end 
  end
end