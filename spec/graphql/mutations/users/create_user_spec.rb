require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :request do
  describe '.resolve' do
    it 'creates a user', :vcr do
      expect(User.count).to eq(0)
      post '/graphql', params: { query: query }
      expect(User.count).to eq(1)
    end

    it 'returns a user', :vcr do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['createUser']
      expect(data['user']).to include(
        'id' => User.last.id.to_s,
        'email' => 'garnet@universe.com',
        'userName' => 'Garnet',
        'image' => 'https://image.png',
        'description' => 'We are a married lesbian couple with kids. We love to play sports and go on adventures!',
        'zipCode' => 80220,
        'lat'     => 39.733854, 
        'lng'     => -104.916649
      )
    end
  end

  def query
    <<~GQL
      mutation {
        createUser(input: {
          userName: "Garnet",
          email: "garnet@universe.com",
          image: "https://image.png",
          description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!",
          zipCode: 80220
       }) { user {
          id
          userName
          email
          description
          image
          zipCode
          lat
          lng
        }
        }
      }
    GQL
  end
end
