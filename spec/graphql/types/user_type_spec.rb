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

  describe '.rsvpd_events(id:)' do 
    it 'returns all events user has rsvpd to' do 
      @user1 = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
      @user2 = User.create(user_name: "Pearl", email: "pearl@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045202-04577eee-4d6b-4a6e-8d71-5b96aef2f6fc.png" , description: "I am a non-binary single parent looking for other enby parents.", zip_code: 80220)
      @event1 = @user1.events.create(title: "Lunch at Denison Park", description: "We are getting together for a meet-and-greet at Denison Park.", time: '18:00:00', date: '2022-10-09', lat: "39.733", lng: "-104.904", address: "1105 Quebec St", city: "Denver", state: "CO", zip: 80220, host: @user1.id)
      @event2 = @user2.events.create(title: "Games at Verbena", description: "Games at Verbena Park", time: '18:00:00', date: '2022-09-15', lat: "39.650", lng: "-104.893", address: "1151 Verbena St", city: "Denver", state: "CO", zip: 80220, host: @user2.id)
      @rsvp = UserEvent.create(user_id: @user1.id, event_id: @event2.id)

      post '/graphql', params: { query: query_two }
      json = JSON.parse(response.body)
      data = json['data']['user']['rsvpdEvents']
      expect(data).to eq([
        {
        "id"          => @event1.id.to_s,
        "title"       => "Lunch at Denison Park",
        "description" => "We are getting together for a meet-and-greet at Denison Park.",
        "zip"         => 80220,
        "lat"         => 39.733,
        "lng"         => -104.904,
        "date"        => "2022-10-09",
        "time"        => "2000-01-01 18:00:00 UTC",
        "host"        => @user1.id
      },
        {
        "id"          => @event2.id.to_s,
        "title"       => "Games at Verbena",
        "description" => "Games at Verbena Park",
        "zip"         => 80220,
        "lat"         => 39.650,
        "lng"         => -104.893,
        "date"        => "2022-09-15",
        "time"        => "2000-01-01 18:00:00 UTC",
        "host"        => @user2.id
      }
      ]
      )
    end
  end

  describe '.near_events(id:)' do 
    it 'returns events in zipcode on users profile' do 
      @user1 = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
      @user2 = User.create(user_name: "Pearl", email: "pearl@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045202-04577eee-4d6b-4a6e-8d71-5b96aef2f6fc.png" , description: "I am a non-binary single parent looking for other enby parents.", zip_code: 80220)
      @user3 = User.create(user_name: "Amethyst", email: "amethyst@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045161-3338af1c-49c6-49fa-a6f3-f850f4f824cd.jpg" , description: "Single queer mom helping raise a 10 year old boy in the Denver area.", zip_code: 80220)

      @event1 = @user1.events.create(title: "Lunch at Denison Park", description: "We are getting together for a meet-and-greet at Denison Park.", time: '18:00:00', date: '2022-10-09', lat: "39.733", lng: "-104.904", address: "1105 Quebec St", city: "Denver", state: "CO", zip: 80220, host: @user1.id)
      @event2 = @user2.events.create(title: "Games at Verbena", description: "Games at Verbena Park", time: '18:00:00', date: '2022-09-15', lat: "39.650", lng: "-104.893", address: "1151 Verbena St", city: "Denver", state: "CO", zip: 80220, host: @user2.id)
      @event3 = @user3.events.create(title: "Birthday Party at Montclair", description: "We will be celebrating Steven's 11th birthday!", time: '18:00:00', date: '2022-10-20', lat: 39.735, lng: -104.908, address: "6820 E 12th Ave", city: "Denver", state: "CO", zip: 80220, host: @user3.id)
      post '/graphql', params: { query: query_three }
      json = JSON.parse(response.body)
      data = json['data']['user']['nearEvents']
      expect(data.count).to eq(3)
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

  def query_two 
    <<~GQL
      {
          user(id: "#{@user1.id}") {
              rsvpdEvents(id: "#{@user1.id}") {
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

  def query_three 
    <<~GQL
      {
          user(id: "#{@user1.id}") {
              nearEvents(id: "#{@user1.id}") {
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