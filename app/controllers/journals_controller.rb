class JournalsController < ApplicationController
  before_action :signed_in_user

def show
  @journal = Journal.find(params[:id])
end

def new
  @journal = Journal.new
end 


def create 
  @journal = Journal.new(journal_params)
  if @journal.save 
    redirect_to journal_path(@journal.id), notice: "You have created a new entry."
  else
    render 'new'
  end
end

def put 
  @journal = Journal.find(params(:id))
  redirect_to journal_path(@journal.id)
end

def edit
  @journal = Journal.find(params(:id))
end

def update 
  @journal = Journal.find(params(:id))
  if @journal.update_attributes(journal_params)
    redirect_to journal_path(@journal.id)
  else 
    render 'edit'
  end
end

def index 
  @journal = Journal.all
end

def destroy 
  @journal = Journal.find(params(:id))
  @journal.destroy
  redirect_to journals_path, notice: "You have deleted an entry"
end


private

  def journal_params
    params.require(:journal).permit(:title, :blog_contents)
  end

  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
end