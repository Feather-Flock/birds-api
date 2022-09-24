class ZipcodeService
  def self.conn
    Faraday.new('https://zipcodeapi.com')
  end

  def self.api_key
    ENV['zipcode_api_key']
  end

  def self.get_zipcode_radius(location, distance)
    response = conn.get("/rest/#{api_key}/radius.json/#{location}/#{distance}/miles?minimal")
    if response.status == 429 
      zip = {:zip_codes=>["80026", "80516", "80514"]}
      return zip
    else 
    JSON.parse(response.body, symbolize_names: true)
    end 
  end
end
