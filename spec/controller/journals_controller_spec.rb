# create a GET tasks#show page when the user visits /tasks/:id
require 'spec_helper'

describe JournalsController, type: :controller do 
  describe "GET show" do 
    #before { @task = Task.new(title: "walk the dog")}
     let(:journal) {FactoryGirl.create(:journal) }  #creates the variables needed without 
     #Task call

     FactoryGirl.create(:journal, name: "Cars") #customizing the variables for 
     #an instance

    it "renders show page" do 
      get :show, id: @journal.id
      expect(response).to render_template(:show)
    end

    it "assigns requested journal to @journal" do 
      get :show, id: journal.id 
      assigns(:journal).should eq(@journal)
    end 
  end

  describe "GET index" do
    before { Journal.destroy_all }

    let(:first_journal) { Journal.create(name: "Cars") }
    let(:second_journal) { Journal.create(name: "Cats") }

    it "renders :index" do 
      get :index
      expect(response).to render_template(:index)
    end 

    it "assigns all journals to @journals as an array" do 
      get :index
      expect(:journal).should eq([first_journal, second_journal])
    end
  end

  describe "GET #new" do 
    it "renders :new" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns new item to the /journal" do 
      get :new
      assigns(:journal).should be_a_new(Journal)
      @journal = Journal.new
    end
  end

  describe "GET #edit" do 
    it "renders :edit"
    it "allows edting of the /journals/:id"
  end 

  describe "POST create Blog item /journal" do
    context "valid attributes" do
      it "creates journal"  do
        expect{
          post :create, journal: {name: "Cars"}
            This will replace the line above when you use FactoryGirl
            post :create, journal: FactoryGirl.attributes_for(:journal)
        }.to change(Journal, :count).by(1)
      end 
      
      it "redirects to :show" do 
        post :create, journal: {name: 'Cars'}
        last_journal = Journal.last 
        expect(response).to redirect_to(journal_path(last_journal.id))
      end 
    end
    
    context "invalid attributes" do 
      it "does not create journal" do 
       expect{
          post :create, journal: {name: ""}
        }.to_not change(Journal, :count)
      end

      it "re-renders :new" do 
        post :create, journal: { name: ""}
        expect(response).to render_template(:new)
      end 
    end
  end

  describe "PUT update" do 
    let(:journal) {Journal.create(name: "Cars") }

    context "vaild attributes" do 
      it "changes @journal's attributes" do 
        put :update, id: journal.id, journal: {name: "Cars"}
        journal.reload
        expect(journal.name).to eq("Cats")
      end 
      it "redirect to :show" do
        put :update, id: journal.id, journal: { name: "Cars"}
        last_journal = Journal.last 
        expect(response).to redirect_to(journal_path(last_journal.id))
      end
    end

    context "invalid attributes" do 
      it "does not change @journal's attributes" do 
        put :update, id: journal.id, journal: {name: ""}
        journal.reload
        expect(journal.name).to eq("Cats")
      end

      it "re-renders :edit" do 
        put :update, id: journal.id, journal: {}
      end

    end

  end


  describe "DELETE destroy" do 
    let!(:journal) { Journal.create(name: "Cars") }

    it "deletes the requested journal" do
      expect{
        delete :destroy, id: journal.id
      }.to change(Journal, :count).by(1)
    end 

    it " redirects to index" do 
      delete :destroy, id: journal.id
      expect(response).to redirect_to(journal_path)
    end 
  end 
end