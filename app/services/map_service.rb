class MapService
  def self.conn
    Faraday.new("http://www.mapquestapi.com")
  end

  def self.api_key
    ENV["map_api_key"]
  end

  def self.get_cords(location)
    response = conn.get("/geocoding/v1/address?key=#{api_key}&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
