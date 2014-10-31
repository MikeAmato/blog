require 'spec_helper'
  
  describe UsersController, type: :controller  do
    describe "GET #new" do 
     it "renders :new" do
       get :new
       expect(response).to render_template(:new)
     end

     it "assigns new item to the /task" do 
        get :new
       assigns(:user).should be_a_new(User)
        @user = User.new
     end
    end
  end

end
