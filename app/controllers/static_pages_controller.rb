class StaticPagesController < ApplicationController
  include SessionHelper
  include JournalHelper

  def home
    @journals = Journal.all.to_a.shuffle
    display_different_blogs_movies
  end


  def search_plot(movie)
    @plots = Tmdb::Movie.find(movie)
    @plots.split(', ')
    @plot = Tmdb::Movie.detail(@plots[0].id)
  end


  def display_different_blogs_movies
    (0..2).each do |i|
      @display_journals = @journals[i]
      @display_plot_zero = search_plot(@journals[0].name)
       @display_plot_one = search_plot(@journals[1].name)
        @display_plot_two = search_plot(@journals[2].name)
    end
  end
end
