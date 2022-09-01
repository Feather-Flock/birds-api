require 'rails_helper'

RSpec.describe Mutations::UpdateEvent, type: :request do
  describe '.resolve' do
    it 'returns an event', :vcr do
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
      event = user.events.create(title: "Lunch at Denison Park", description: "We are getting together for a meet-and-greet at Denison Park.", time: '18:00:00', date: '2022-10-09', address: "1105 Quebec St", city: "Denver", state: "CO", zip: 80220, host: user.id)
      post '/graphql', params: { query: query(id: event.id, user_id: user.id) }
      json = JSON.parse(response.body)
      require "pry";binding.pry
      data = json['data']['updateEvent']
      expect(data["event"]).to include(
        "title"       => "Lunch at Denison Park",
        "description" => "We are getting together for a meet-and-greet at Denison Park.",
        "time"        => "18:00:00",
        "date"        => "2022-10-09",
        "address"     => "1105 Quebec St",
        "city"        => "Denver",
        "state"       => "CO",
        "zip"         => 80220,
        "host"        => user.id
      )
    end

    xit 'updates an event', :vcr do
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
      post '/graphql', params: { query: update_query(id: event.id, user_id: user.id) }
      json = JSON.parse(response.body)
      data = json['data']['updateEvent']
      expect(data["event"]).to include(
        "title"       => "Lunch at Denison Park",
        "description" => "We are getting together for a meet-and-greet at Denison Park.",
        "time"        => "14:00:00",
        "date"        => "2022-10-09",
        "address"     => "1105 Quebec St",
        "city"        => "Denver",
        "state"       => "CO",
        "zip"         => 80220,
        "host"        => user.id
      )
    end
  end

  def query(id:, user_id:)
    <<~GQL
      mutation {
        updateEvent(input: {
          id: #{id}
          title: "Lunch at Denison Park",
          description: "We are getting together for a meet-and-greet at Denison Park.",
          time: "18:00:00",
          date: "2022-10-09",
          address: "1105 Quebec St",
          city: "Denver",
          state: "CO",
          zip: 80220,
          host: #{user_id}
       }) { event {
          title
          description
          time
          date
          address
          city
          state
          zip
          lat
          lng
          host
        }
      }
    }
  GQL
  end

  def update_query(id:, user_id:)
    <<~GQL
      mutation {
        updateEvent(input: {
          id: #{id}
          title: "Lunch at Denison Park",
          description: "We are getting together for a meet-and-greet at Denison Park.",
          time: "14:00:00",
          date: "2022-10-09",
          address: "1105 Quebec St",
          city: "Denver",
          state: "CO",
          zip: 80220,
          host: #{user_id}
       }) { event {
          title
          description
          time
          date
          address
          city
          state
          zip
          lat
          lng
          host
        }
      }
    }
  GQL
  end
end
