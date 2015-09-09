ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'test/unit'
require 'rack/test'
require 'json'
require 'pry'

class SinatraAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    App
  end

  def test_returns_all_listings
    get '/listings'
    assert last_response.ok?
    assert_equal JSON.parse(last_response.body)['features'].length, 9999
  end

end