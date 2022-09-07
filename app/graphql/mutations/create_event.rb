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
  argument :slug, String, required: true
  # argument :user_id, Integer, required: true
  # user id to find user


  field :event, Types::EventType, null: false
  field :user_event, Types::UserEventType, null: false
  field :errors, [String], null: false

  def resolve(title:, description:, time:, date:, address:, city:, state:, zip:, host:, slug:)
    location = "#{address} #{city} #{state} #{zip}"
    cords = MapFacade.create_cords(location)
    event = Event.create!(title: title, description: description, time: time, date: date, lat: cords[:lat],
                         lng: cords[:lng], address: address, city: city, state: state, zip: zip, host: host.to_i, slug: slug)
    
    if event.save
      user = User.find(host)
      user.user_events.create(user_id: host, event_id: event.id)
      event.update(rsvps: event.user_events.count)
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
