require 'rails_helper'

RSpec.describe Mutations::UpdateUser, type: :request do
  describe '.resolve' do
    it 'updates a user', :vcr do 
      user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220, lat: '39.73', lng: '-104.91')
      expect(user.user_name).to eq("Garnet")

      post '/graphql', params: { query: update_query(id: user.id) }

      json = JSON.parse(response.body)
      data = json['data']['updateUser']

      expect(data["user"]).to include( 
        "userName" => "Garnet Universe"
      )
    end

    describe 'sad path' do
      it 'will not update user without user id', :vcr do

        post '/graphql', params: { query: sad_path_query(id: nil) }

        json = JSON.parse(response.body)

        expect(json['errors'].first['message']).to eq("Argument 'id' on InputObject 'UpdateUserInput' is required. Expected type Int!")
      end
    end
  end 

  def update_query(id:)
    <<~GQL
      mutation {
        updateUser(input: {
          id: #{id},
          userName: "Garnet Universe", 
          email: "garnet@universe.com",
          image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png",
          description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!",
          zipCode: 80220,
          lat: 39.73,
          lng: -104.91
         }) { user {
            userName
          }
        }
      }
    GQL
  end

  def sad_path_query(id:)
    <<~GQL
      mutation {
        updateUser(input: {
          userName: "Garnet Universe", 
          email: "garnet@universe.com",
          image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png",
          description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!",
          zipCode: 80220,
          lat: 39.73,
          lng: -104.91
         }) { user {
            userName
          }
        }
      }
    GQL
  end
end