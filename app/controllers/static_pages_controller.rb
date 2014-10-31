class StaticPagesController < ApplicationController
  include SessionHelper
  include JournalHelper

  def home
    @movie = search("cars")
    @journals = Journal.all.to_a.shuffle

    search_plot(@journals[0].name)
  end


  def search_plot(movie)
    @plots = Tmdb::Movie.find(movie)
    @plots.split(', ')
    @plot = Tmdb::Movie.detail(@plots[0].id)
  end
end
