require 'spec_helper'

describe "journals_pages" do
  
  subject { page }

  describe "show page GET /journal/:id" do
    let(:journal) { Journal.create(name: "John Smith") }

    before { visit journal_path(journal.id) }

    it { should have_title("Blog | Show Blog") }
    it { should have_selector('h1', "John Smith's blog") }
    it { should have_selector('p', journal.title) }

  end


  describe "new page GET /journal/new" do 
    #Visit the new page
    before { visit new_journal_path }

    it { should have_title("Blog | New Blog") }
    it { should have_selector('h1', "New Blog") }
    #test that it has the correct title and header
    
    #test the create action
    describe "create POST /journal" do 
      let(:submit) { "Create" }

      context "Valid information" do
        before do
          visit new_journal_path
          fill_in "Name", with: "Cars"
          fill_in "blog_contents", with: "Great movie"
        end
        it "creates journal" do 
          expect { click_button submit }.to change(Journal, :count).by(1)
        end

        describe "after submission" do 
          before { click_button submit }

          it { should have_title('Blog | Show Journal') } 
          it {should have_selector('p', 'Cars') }
        end 
      end
      
      context "invalid information"  do 
        it "does not create task" do 
          expect { click_button submit }.not_to change(Journal, :count)
        end

        describe "after submission" do 
          before { click_button submit}

          it {should have_title('Blog | New Journal') }
          it { should have_content('error')}
        end 
      end   
    end 
  end


  describe "index page GET journal" do 
    before {visit task_path }

    it {should have_title('Blog | My Journal') }
    it {should have_selector('h1', 'All Journal') }

    describe "destroy delete journal/:id" do 
      it { should have_link('delete', href: journal_path(journal.id))}

      it "destroys the journal" do 
        expect{
          click_link('delete', match: :first)
        }.to change(Journal, :count).by(-1)
      end 
    end 
  end

  describe "GET edit" do 
    let(:journal) {Journal.create(name: "Cars") }

    it "renders :edit" do 
      get :edit, id: journal.id 
       expect(response).to render_template(:edit)
    end

    it "assigns requested journal to @journal" do 
      get :edit, id: journal.id
      assigns(:journal).should eq(journal)
    end 
  end 

  describe "edit page GET journals/:id/edit" do 
    let(:journal) {journal.create(name: "Cars") }

    before { visit edit_journal_path(journal.id)}

    it { should have_title("Blog | Edit Blog")}
    it { should have_selector('h1', text: 'Edit Blog') }    

    describe "update PUT journals/:id" do 
      let(:submit) {"Save Changes"}

      context "vaild information" do 
        before do
          fill_in "name", with: "Cars"
          click_button submit
        end

        it {should have_title("Blog | Show Blog") }
        it {should have_selector('p', text: "Cars") }
        specify { expect(journal.reload.title).to eq("Cars") }
      end  

      context "invalid information" do 
        before do
          fill_in "Title", with: " "
          click_button submit
        end 
        it { should have_title('Blog | Edit Blog') }
        it { should have_content('error') }
      end 
    end
  end 
end