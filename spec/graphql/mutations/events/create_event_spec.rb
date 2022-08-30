require 'rails_helper'

RSpec.describe Mutations::CreateEvent, type: :request do
  describe '.resolve' do
    it 'creates an event', :vcr do
      expect(Event.count).to eq(0)
      post '/graphql', params: { query: query }
      expect(Event.count).to eq(1)
    end

    it 'returns an event', :vcr do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['createEvent']
      expect(data["event"]).to include(
        "title"       => "Park hangout",
        "description" => "Single dad hanging with 7 year old son and friends at park",
        "time"        => "2000-01-01 12:00:00 UTC",
        "date"        => "2022-09-23",
        "address"     => "2455 Bryant Street",
        "city"        => "Denver",
        "state"       => "CO",
        "zip"         => 80211,
        "host"        => 1
      )
    end
  end

    def query
      <<~GQL
      mutation {
        createEvent(input: {
          title: "Park hangout",
          description: "Single dad hanging with 7 year old son and friends at park",
          time: "12:00:00",
          date: "2022-09-23",
          address: "2455 Bryant Street",
          city: "Denver",
          state: "CO",
          zip: 80211,
          host: 1
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
