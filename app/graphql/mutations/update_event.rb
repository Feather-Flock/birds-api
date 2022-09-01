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
  field :user_event, Types::UserEventType, null: false
  field :errors, [String], null: false


end
