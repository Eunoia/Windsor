require 'pry'
require 'sinatra/base'
require 'sinatra/param'
require 'json'

require_relative 'listings'

$listings = Listings.new('listings.csv')

class App < Sinatra::Base
  helpers Sinatra::Param

  before do
    content_type :json
  end

  get '/' do
    send_file "public/index.html", :type => :html
  end

  get '/listings'  do
    param :min_price, Integer, default: -1
    param :max_price, Integer, default: Float::INFINITY
    param :min_bed, Integer, default: -1
    param :max_bed, Integer, default: Float::INFINITY
    param :min_bath, Integer, default: -1
    param :max_bath, Integer, default: Float::INFINITY
    param :since, Integer
    param :count, Integer, default: -1

    @listings = $listings.search(params, params['count'])
    erb :listings
  end
end
