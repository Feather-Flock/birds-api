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

  def resolve(id:, **arguments)
    event = Event.find(id)
      if event.update(arguments)
      { event: event }
    else
      { errors: event.errors.full_messages }
    end
  end
end
