require 'rails_helper'

RSpec.describe Mutations::UpdateEvent, type: :request do
  describe '.resolve' do
    xit 'returns an event', :vcr do
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
      post '/graphql', params: { query: query(user_id: user.id) }
      json = JSON.parse(response.body)
      data = json['data']['updateEvent']
      expect(data["event"]).to include(
        "title"       => "Park hangout",
        "description" => "Single dad hanging with 7 year old son and friends at park",
        "time"        => "12:00:00",
        "date"        => "2022-09-23",
        "address"     => "2455 Bryant Street",
        "city"        => "Denver",
        "state"       => "CO",
        "zip"         => 80211,
        "host"        => user.id
      )
    end

    xit 'updates an event', :vcr do
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
      post '/graphql', params: { query: update_query(id: event.id, user_id: user.id) }
      json = JSON.parse(response.body)
      data = json['data']['updateEvent']
      expect(data["event"]).to include(
        "title"       => "Park hangout",
        "description" => "Single dad hanging with 7 year old son and friends at park",
        "time"        => "2:00:00",
        "date"        => "2022-09-23",
        "address"     => "2455 Bryant Street",
        "city"        => "Denver",
        "state"       => "CO",
        "zip"         => 80211,
        "host"        => user.id
      )
    end
  end

  def query(user_id:)
    <<~GQL
      mutation {
        updateEvent(input: {
          title: "Park hangout",
          description: "Single dad hanging with 7 year old son and friends at park",
          time: "12:00:00",
          date: "2022-09-23",
          address: "2455 Bryant Street",
          city: "Denver",
          state: "CO",
          zip: 80211,
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
          title: "Park hangout",
          description: "Single dad hanging with 7 year old son and friends at park",
          time: "2:00:00",
          date: "2022-09-23",
          address: "2455 Bryant Street",
          city: "Denver",
          state: "CO",
          zip: 80211,
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
