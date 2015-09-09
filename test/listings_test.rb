require 'pry'
require 'test/unit'
require_relative '../listings.rb'

class ListingsTest < Test::Unit::TestCase
  MEDIAN_PROPERTY_PRICE = 201_589

  def test_returns_all_listings_from_empty_params
    listings = Listings.new('listings.csv')
    assert_equal listings.search.length, 9999
  end

  def test_returns_half_listings_with_price_above_median
    listings = Listings.new('listings.csv')
    subset = listings.search('max_price' => MEDIAN_PROPERTY_PRICE)
    assert_equal subset.length, 5000
  end

  def test_returns_few_listings_with_all_params
    listings = Listings.new('listings.csv')
    subset = listings.search(
      'max_price' => MEDIAN_PROPERTY_PRICE,
      'min_price' => MEDIAN_PROPERTY_PRICE - 200,
      'min_bed' => 3,
      'max_bed' => 4,
      'min_bath' => 2,
      'max_bath' => 3
    )
    assert_equal subset.length, 3
  end

  def test_since_and_offset_return_limited_values
    listings = Listings.new('listings.csv')
    subset = listings.search({ 'since' => 10 }, 10)
    assert_equal subset.last[:id], 21
  end
end
