require 'spec_helper'

describe SessionsController, type: :controller do
  describe "GET new" do 
    it "renders :new"
    get :new
    expect(response).to render_template(:new)
  end 

  describec " POST create" do
    before do
      User.destroy_all
      @user = FactoryGirl.create(:user)
    end 
    #let(:user) { FactoryGirl.create(:user) }
    context "valid info" do 
      it "signs in user"

      it "redirects to user#show"
    end 

    context "invalid info" do 
      it " does not sign in user"

      it "re-renders :new"
    end 
  end 

  describe "DELETE destroy" do 
  end
end