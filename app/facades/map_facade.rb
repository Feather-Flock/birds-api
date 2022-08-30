class MapFacade
  def self.create_cords(location)
    data = MapService.get_cords(location)
    data[:results][0][:locations][0][:latLng]
  end
end
