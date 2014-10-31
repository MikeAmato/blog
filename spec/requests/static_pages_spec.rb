require 'spec_helper'

describe "static_pages" do
  
  subject { page }

  describe "home page" do
    # 1. visit the home page
    before { visit home_path }
    # test - it should have a h1 of welcome
    it { should have_selector('h1', "Welcome") }  
    # test - it should have a title of blog | home
    it { should have_title("Blog | Home") }
  end
end