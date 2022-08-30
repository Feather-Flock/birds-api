# frozen_string_literal: true

module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :description, String
    field :time, String
    field :date, GraphQL::Types::ISO8601Date
    field :lat, Float
    field :lng, Float
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :address, String
    field :city, String
    field :state, String
    field :zip, Integer
    field :host, Integer

  end
end
