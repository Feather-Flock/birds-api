require 'rails_helper'

RSpec.describe Types::UserType, type: :request do
  describe '.user_events(id:)' do 
    it 'returns a users created events' do 
      @user1 = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
      @event1 = @user1.events.create(title: "Lunch at Denison Park", description: "We are getting together for a meet-and-greet at Denison Park.", time: '18:00:00', date: '2022-10-09', lat: "39.733", lng: "-104.904", address: "1105 Quebec St", city: "Denver", state: "CO", zip: 80220, host: @user1.id)
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['user']['userEvents']
      expect(data).to eq([
        "id"          => @event1.id.to_s,
        "title"       => "Lunch at Denison Park",
        "description" => "We are getting together for a meet-and-greet at Denison Park.",
        "zip"         => 80220,
        "lat"         => 39.733,
        "lng"         => -104.904,
        "date"        => "2022-10-09",
        "time"        => "2000-01-01 18:00:00 UTC",
        "host"        => @user1.id
    ])
    end
  end

  def query 
    <<~GQL
      {
          user(id: "#{@user1.id}") {
              userEvents(id: "#{@user1.id}") {
                  id
                  title
                  description
                  zip
                  lat
                  lng
                  date
                  time
                  host
              }
          }
      }
    GQL
  end
end 