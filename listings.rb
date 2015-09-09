require 'csv'

class Listings
  def initialize(file = 'listings.csv')
    @listings = []
    CSV.foreach(file, csv_parsing_options) do |row|
      @listings << Hash[row.headers.zip(row.fields)]
    end
  end

  def csv_parsing_options
    {
      :headers => true,
      :header_converters => :symbol,
      :converters => :all
    }
  end

  def default_params
    {
      'since' => 0,
      'min_price' => -1,
      'max_price' => Float::INFINITY,
      'min_bed' => -1,
      'max_bed' => Float::INFINITY,
      'min_bath' => -1,
      'max_bath' => Float::INFINITY
    }
  end

  def search(params = {}, count = -1)
    params  = default_params.merge params
    @listings.select do |listing|
      [
        listing[:id] > params['since'],
        (params['min_price']..params['max_price']) === listing[:price],
        (params['min_bed']..params['max_bed']) === listing[:bedrooms],
        (params['min_bath']..params['max_bath']) === listing[:bathrooms]
      ].compact.all? { |a| a == true }
    end[0..count]
  end
end
