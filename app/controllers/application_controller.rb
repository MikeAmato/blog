class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'themoviedb'
  include SessionHelper
  include JournalHelper
  before_filter :set_config
  Tmdb::Api.key("c4c92e2efd9af3dc0e8f71da5824e144")

  def set_config
    @configuration = Tmdb::Configuration.new
  end
end



