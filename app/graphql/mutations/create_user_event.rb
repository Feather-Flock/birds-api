class Mutations::CreateUserEvent < Mutations::BaseMutation 
  argument :user_id, String, required: true 
  argument :event_id, String, required: true

  field :user_event, Types::UserEventType, null: false 
  field :errors, [String], null: false
  field :event, Types::EventType, null: false 

  def resolve(user_id:, event_id:)
    uv = UserEvent.new(user_id: user_id.to_s, event_id: event_id.to_s)
    if uv.save 
      event = Event.find(event_id)
      event.update(rsvps: event.user_events.count)
      {
        user_event: uv, 
        errors: []
      }
    else 
      {
        user_event: nil, 
        errors: uv.errors.full_messages
      }
    end
  end
end