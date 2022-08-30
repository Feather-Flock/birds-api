# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String
    field :user_name, String
    field :image, String
    field :description, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :zip_code, Integer
    

    field :rsvpd_events, [Types::EventType], null: false do
      argument :id, ID, required: true
    end 

    def rsvpd_events(id:) 
      user = User.find(id)
      user.events
    end

    field :user_events, [Types::EventType], null: false do 
      argument :id, ID, required: true
    end

    def user_events(id:)
      user = User.find(id)
      rsvp = user.events
      rsvp.where("host = ?", user.id)
    end

    field :near_events, [Types::EventType], null: false do 
      argument :id, ID, required: true
    end

    def near_events(id:)
      user = User.find(id)
      Event.where("zip = ?", user.zip_code)
    end
  end
end
