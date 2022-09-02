require 'rails_helper'

RSpec.describe Mutations::DestroyEvent, type: :request do
  describe '.resolve' do
    it 'destroys an event', :vcr do
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
      event = user.events.create(title: "Lunch at Denison Park", description: "We are getting together for a meet-and-greet at Denison Park.", time: '18:00:00', date: '2022-10-09', lat: "39.733", lng: "-104.904", address: "1105 Quebec St", city: "Denver", state: "CO", zip: 80220, host: user.id)

      post '/graphql', params: { query: destroy_query(id: event.id) }

      json = JSON.parse(response.body)
      data = json['data']['destroyEvent']

      expect(data).to include(
        "title"       => "Lunch at Denison Park",
        "description" => "We are getting together for a meet-and-greet at Denison Park.",
        "time"        => "18:00:00",
        "date"        => "2022-10-09",
        "address"     => "1105 Quebec St",
        "city"        => "Denver",
        "state"       => "CO",
        "zip"         => 80220
      )
      expect(Event.count).to eq(0)
    end

    def destroy_query(id:)
      <<~GQL
        mutation {
          destroyEvent(input: {
            id: #{id}
            }){
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
            }
          }
      GQL
    end
  end
end
