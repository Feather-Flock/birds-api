# frozen_string_literal: true

module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :description, String
    field :time, String
    field :date, String
    field :lat, Float
    field :lng, Float
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :address, String
    field :city, String
    field :state, String
    field :zip, Integer
    field :host, Integer
    field :rsvps, Integer

    field :creator, Types::UserType, null: false do 
      argument :id, Integer, required: true
    end

    def creator(id:)
      event = Event.find(id)
      User.find(event.host)
    end
  end
end
