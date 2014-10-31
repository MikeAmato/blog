class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :signed_in_user, only: [:show]

  def new 
    @user = User.new
  end

  def create
   @user = User.new(user_params)
   if @user.save
     sign_in(@user)
     session[:current_user_id] = @user.id
      redirect_back_or(user_path(@user.id))
   else
      flash[:error] = "Cannot create a user, check the input and try again"
      render 'new'
    end
  end

  def show
   @user = User.find(params[:id])
  end

  def edit 
    @user = User.find(params[:id])
  end 

  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "You have successfully edited your information"
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end 
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, 
        :age, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def signed_in_user
      unless signed_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to(root_path) unless current_user?(@user)
      end
    end
end