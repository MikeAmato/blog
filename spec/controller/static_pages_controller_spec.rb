require 'spec_helper'

describe StaticPagesController, type: :controller  do
  describe "home" do
    it "renders home" do
      get :home
      expect(response).to render_template(:home)
    end 
  end 
end