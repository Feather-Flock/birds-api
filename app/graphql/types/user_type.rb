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
    field :lat, Float
    field :lng, Float

    field :errors, [String], null: false

    field :rsvpd_events, [Types::EventType], null: false do
      argument :id, ID, required: true
    end

    def rsvpd_events(id:)
      user = User.find(id)
      user.events.where('host != ?', user.id)
    end

    field :user_events, [Types::EventType], null: false do
      argument :id, ID, required: true
    end

    def user_events(id:)
      user = User.find(id)
      rsvp = user.events
      rsvp.where('host = ?', user.id)
    end

    field :near_events, [Types::EventType], null: false do
      argument :id, ID, required: true
    end

    def near_events(id:)
      user = User.find(id)
      events = Event.where('zip = ?', user.zip_code)
      events.where('host != ?', user.id)
    end

    field :user_defined, [Types::EventType], null: true do
      argument :id, ID, required: true
      argument :range, Integer, required: true
    end

    def user_defined(id:, range:)
      user = User.find(id)
      array =  ZipcodeFacade.create_zipcodes(user.zip_code, range)
      events = []
      if array.nil? 
        array = [user.zip_code]
      end
      array.find_all do |e|
        match = Event.where('zip = ?', e).where('host != ?', user.id)
        if match != []
          events << match
        end 
      end 
        events.flatten
    end
  end
end
