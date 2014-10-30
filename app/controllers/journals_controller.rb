class JournalsController < ApplicationController
  include SessionHelper
  include JournalHelper
  before_action :signed_in_user

def show
  @movie = search("cars")
end

def new
  @journal = Journal.new
end

def create 
  @journal = current_user.journals.build(journal_params)  #//for current user
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

def update 
  @journal = Journal.find(params(:id))
  if @journal.update_attributes(journal_params)
    redirect_to journal_path(@journal.id)
  else 
    render 'edit'
  end
end

def index 
  @journals = current_user.journals
end

def destroy 
  @journal = Journal.find(params(:id))
  @journal.destroy
  redirect_to journals_path, notice: "You have deleted an entry"
end

private

  def journal_params
    params.require(:journal).permit(:name, :blog_contents)
  end

  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
end