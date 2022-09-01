class Mutations::UpdateEvent < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :title, String, required: false
  argument :description, String, required: false
  argument :time, String, required: false
  argument :date, String, required: false
  argument :address, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, Integer, required: false
  argument :host, Integer, required: false

  field :event, Types::EventType, null: false
  field :errors, [String], null: false

  def resolve(id:, title:, description:, time:, date:, address:, city:, state:, zip:, host:)
    location = "#{address} #{city} #{state} #{zip}"
    cords = MapFacade.create_cords(location)
    event = Event.find(id)
      if event.update(title: title, description: description, time: time, date: date, lat: cords[:lat], lng: cords[:lng], address: address, city: city, state: state, zip: zip, host: host.to_i)
      { event: event }
    else
      { errors: event.errors.full_messages }
    end
  end
end
