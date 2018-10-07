class BeermappingApi
  def self.places_in(city)
    city = city.downcase

    places = Rails.cache.read(city)

    if places.nil?
      places = get_places_in(city)
      Rails.cache.write(city, places, expires_in: 1.week.to_i)
    end
    places
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/" 
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.collect{ |h| Place.new h }
  end

  def self.key
    '9f31970b43b833a07e33788cca519330'
  end
end
