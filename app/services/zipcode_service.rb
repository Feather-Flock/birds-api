class ZipcodeService
  def self.conn
    Faraday.new('https://zipcodeapi.com')
  end

  def self.api_key
    ENV['zipcode_api_key']
  end

  def self.get_zipcode_radius(location, distance)
    response = conn.get("/rest/#{api_key}/radius.json/#{location}/#{distance}/miles?minimal")
    JSON.parse(response.body, symbolize_names: true)
  end
end
