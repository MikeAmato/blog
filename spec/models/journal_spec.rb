require 'spec_helper'

describe Journal do 
  let(:user) { FactoryGirl.create(:user) }
  
  before { @journal = Journal.new(name: "Cars", blog_content: "Great movie") }

  subject { @journal }

  it { should respond_to(:blog_content) }
  it { should respond_to(:name) }
  it {should respond_to(:user) }
  it { should respond_to(:user_id) }
  it { should be_valid }

  describe "validations" do 
    describe "title" do 
      describe "not present" do
        before {@journal.name = " " }
        it { should_not be_valid }
      end

      describe "too short" do
        before { @journal.name = "a" * 2}
      it { should_not be_valid }
      end 

      describe "too long" do 
        before { @journal.name = "a" * 255 }
        it { should_not be_valid }
      end 

      describe "completed" do 
        it "false by default" do
          @journal = Journal.new(name: "Cars")
        end
      end 

      describe " user_id" do 
        context "not present" do 
          before { @journal.user_id = nil }
          it { should_not be_valid }
        end
      end 
    end 

    describe "description" do 
      describe "not present" do
        before { @journal.description = " " }
        it  { should_not be_valid }
      end

      describe "too short" do
        before { @journal.description = "a" * 2 }
        it { should_not be_valid }
      end

      describe "too long" do
        before { @journal.description = "a" * 255 }
        it { should_not be_valid }
      end
    end
  end 
end 