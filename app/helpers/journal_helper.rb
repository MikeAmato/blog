module JournalHelper
require 'httparty'
require 'json'

  def search(name)
    #options = {:query => { :q => name, :api_key => "rm9au8yvr5y2fgb8sbp2k94h"} }

    #response = HTTParty.get('http://api.rottentomatoes.com/api/public/v1.0/movies.json', options)
    response = HTTParty.get "http://api.rottentomatoes.com/api/public/v1.0/movies.json?q=#{name}&page_limit=1&page=1&apikey=rm9au8yvr5y2fgb8sbp2k94h"
                             #http://api.rottentomatoes.com/api/public/v1.0/movies/770672122.json?apikey=rm9au8yvr5y2fgb8sbp2k94h
    JSON.parse(response.body)
  end
end