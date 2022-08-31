class Mutations::CreateEvent < Mutations::BaseMutation
  argument :title, String, required: true
  argument :description, String, required: true
  argument :time, String, required: true
  argument :date, String, required: true
  argument :address, String, required: true
  argument :city, String, required: true
  argument :state, String, required: true
  argument :zip, Integer, required: true
  argument :host, Integer, required: true

  #user id to find user
  #argument :id, Integer, required: true

  field :event, Types::EventType, null: false
  field :errors, [String], null: false

  def resolve(title:, description:, time:, date:, address:, city:, state:, zip:, host:)

    #user = user(id:)
    addy = "#{address} #{city} #{state} #{zip}"
    cords = MapFacade.create_cords(addy)
    #user.event.create
    event = Event.new(title: title, description: description, time: time, date: date, lat: cords[:lat], lng: cords[:lng], address: address, city: city, state: state, zip: zip, host: host.to_i)
    if event.save
      {
        event: event,
        errors: []
      }
    else
      {
        event: nil,
        errors: event.errors.full_messages
      }
    end
  end
end
