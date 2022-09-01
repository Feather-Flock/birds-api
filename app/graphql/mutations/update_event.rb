class Mutations::UpdateEvent < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :title, String, required: true
  argument :description, String, required: true
  argument :time, String, required: true
  argument :date, String, required: true
  argument :address, String, required: true
  argument :city, String, required: true
  argument :state, String, required: true
  argument :zip, Integer, required: true
  argument :host, Integer, required: true

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
