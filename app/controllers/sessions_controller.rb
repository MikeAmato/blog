class SessionsController < ApplicationController

  def new 
   #Check if new session and create session are basically the same things
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && User.authenticate(params[:session][:password])
      sign_in(user)
      redirect_back_or user_path(user)
    else
      render 'new'
    end
  end

  def destroy
    #have to look up how to destroy a session 
  end


#####this is a raise exception for the returned auth
  # s

end