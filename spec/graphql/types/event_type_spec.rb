require 'rails_helper'

RSpec.describe Types::EventType, type: :request do 
  describe '.event(id:)' do 
    it 'returns all event details' do 
      @user1 = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220, lat: '39.73', lng: '-104.91')
      @event1 = @user1.events.create(title: "Lunch at Denison Park", description: "We are getting together for a meet-and-greet at Denison Park.", time: '18:00:00', date: '2022-10-09', lat: "39.733", lng: "-104.904", address: "1105 Quebec St", city: "Denver", state: "CO", zip: 80220, host: @user1.id)
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['event']
      expect(data).to include(
        "id"          => @event1.id.to_s,
        "title"       => "Lunch at Denison Park",
        "description" => "We are getting together for a meet-and-greet at Denison Park.",
        "zip"         => 80220,
        "lat"         => 39.733,
        "lng"         => -104.904,
        "date"        => "2022-10-09",
        "time"        => "18:00:00",
        "host"        => @user1.id
      )
    end

    it 'returns creator of event' do 
      @user1 = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220, lat: '39.73', lng: '-104.91')
      @event1 = @user1.events.create(title: "Lunch at Denison Park", description: "We are getting together for a meet-and-greet at Denison Park.", time: '18:00:00', date: '2022-10-09', lat: "39.733", lng: "-104.904", address: "1105 Quebec St", city: "Denver", state: "CO", zip: 80220, host: @user1.id)
      post '/graphql', params: { query: query_two }
      json = JSON.parse(response.body)
      data = json['data']['event']['creator']
      expect(data).to include(
                "id"         => "#{@user1.id}",
                "userName"    => "Garnet",
                "description" => "We are a married lesbian couple with kids. We love to play sports and go on adventures!"
      )

    end

    def query
      <<~GQL
        {
          event(id: #{@event1.id}) {
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
      GQL
    end 

    def query_two
      <<~GQL
        {
          event(id: #{@event1.id}) {
            creator(id: #{@event1.id}) {
              id
              userName
              description
              }
            }
          }
      GQL
    end
  end
end