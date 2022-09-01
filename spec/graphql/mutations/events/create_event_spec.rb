require 'rails_helper'

RSpec.describe Mutations::CreateEvent, type: :request do
  describe '.resolve' do
    it 'creates an event', :vcr do
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)

      expect(Event.count).to eq(0)
      expect(UserEvent.count).to eq(0)

      post '/graphql', params: { query: query(user_id: user.id) }

      expect(Event.count).to eq(1)
      expect(UserEvent.count).to eq(1)
      expect(Event.last.rsvps).to eq(1)
    end

    it 'returns an event', :vcr do
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)

      post '/graphql', params: { query: query(user_id: user.id) }

      json = JSON.parse(response.body)
      data = json['data']['createEvent']
      
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
  end

  describe 'sad path' do
    it 'will not create an event if argument is missing', :vcr do
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)

      post '/graphql', params: { query: sad_path_query(user_id: user.id) }
      json = JSON.parse(response.body)

      expect(json['errors'].first['message']).to eq("Argument 'date' on InputObject 'CreateEventInput' is required. Expected type String!")
    end
  end

    def query(user_id:)
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

def sad_path_query(user_id:)
  <<~GQL
    mutation {
      createEvent(input: {
        title: "Park hangout",
        description: "Single dad hanging with 7 year old son and friends at park",
        time: "12:00:00",
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
