#users can signup for the sire with a valid name and email
addresses = %w[user@foo.com]  #different examples of emails
addresses.each do |valid_address|
  @user.email = valid_address
  expect(@user).to be_valid
end


  User.destroy_all   #random code snippet
  # Users can sign up for the site with a valid name and email

require 'spec_helper'

describe User do
  before { @user = User.new(name: "John Smith", email: "jsmith@gmail.com",
                  password: = "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:journals) }
  it { should be_valid }


  describe "validations" do
    describe "name" do
      context "not present" do
        before { @user.name = " " }
        it { should_not be_valid }
      end

      context "too long" do
        before { @user.name = "a" * 51 }
        it { should_not be_valid }
      end
    end

    describe "email" do
      context "not present" do
        before { @user.email = " " }
        it { should_not be_valid }
      end

      context "too long" do
 
       before { @user.email = "a" * 201 }
        it { should_not be_valid }
      end

      context "correct format" do
        it "is valid" do
          addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
          addresses.each do |valid_address|
            @user.email = valid_address
            expect(@user).to be_valid
          end
        end
      end

      context "incorrect format " do
        it "is invalid" do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com foo@bar..com]
          addresses.each do |invalid_address|
            @user.email = invalid_address
            expect(@user).to_not be_valid
          end
        end
      end

      context "mixed case" do
        it "is saved as lowercase" do
          mixed_case_email = "fooBAR@exaMPlE.coM"
          @user.email = mixed_case_email
          @user.save
          expect(@user.reload.email).to eq mixed_case_email.downcase
        end
      end

      context "when already taken" do
        before do
          user_with_same_email = @user.dup
          user_with_same_email.save
        end

        it { should_not be_valid }
        
        User.destroy_all
      end
    end

    describe "password" do 
      context "not present" do 
        before {@user.password = @user.password_confirmation = " "}
        it { should_not be_valid}
      end 
    
      context "too short" do 
        before {@user.password = @user.password_confirmation = "a" * 5}
        it {should_not be_valid}
      end 

      context "doesn't match confimation" do 
        before {@user.password_confirmation = "mismatch"}
       it {should_not be_valid}
     end

      describe "return value of auth method" do
        before do
          User.destroy_all
          @user.save 
        end

        let(:found_user) { User.find_by(email: @user.email) }

        context "with valid password" do 
          it { should eq found_user.authenticate(@user.password) }
        end 

       context " with invalid password" do 
          let(:user_for_invalid_password) { found_user.authenticate("invalid_password") }

          it { should_not eq user_for_invalid_password }
          specify { expect(user_for_invalid_password).to be_falsey }
       end 

      describe "remember token" do 
        before do
          User.destroy_all
          @user.save 
        end

          it "has a default value" do 
            expect (@user.remember_token).to_not be_blank
          end 

      end
    end 
  end

  describe "associations" do 
    before { @user.save }

    describe "task" do
      let(:journal) { FactoryGirl.create(:journal, user_id: @user.id) }
      context "on user destroy" do
        it "destroys all associated journals" do 
          tasks = @user.journals.to_a
          @user.destroy
          expect(journals).not_to be_empty
          journals.each do |journal|
            expect(Journal.where(id: journal.id)).to be_empty
          end
        end 
      end
    end
  end 
end