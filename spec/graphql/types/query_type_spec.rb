require 'rails_helper'

RSpec.describe Types::UserType, type: :request do
  describe '.user(id:)' do
    it 'returns all details of a user' do
      @user = User.create(user_name: 'Garnet', email: 'garnet@universe.com', image: 'https://image.png',
                          description: 'We are a married lesbian couple with kids. We love to play sports and go on adventures!', zip_code: 80_220)
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['user']
      expect(data).to include(
        'id' => @user.id.to_s,
        'email' => 'garnet@universe.com',
        'userName' => 'Garnet',
        'image' => 'https://image.png',
        'description' => 'We are a married lesbian couple with kids. We love to play sports and go on adventures!',
        'zipCode' => 80_220
      )
    end
  end

  describe '.users' do
    it 'returns all users' do
      @user1 = User.create(user_name: 'Garnet', email: 'garnet@universe.com',
                           image: 'https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png', description: 'We are a married lesbian couple with kids. We love to play sports and go on adventures!', zip_code: 80_220)
      @user2 = User.create(user_name: 'Pearl', email: 'pearl@universe.com',
                           image: 'https://user-images.githubusercontent.com/99059063/187045202-04577eee-4d6b-4a6e-8d71-5b96aef2f6fc.png', description: 'I am a non-binary single parent looking for other enby parents.', zip_code: 80_220)
      @user3 = User.create(user_name: 'Amethyst', email: 'amethyst@universe.com',
                           image: 'https://user-images.githubusercontent.com/99059063/187045161-3338af1c-49c6-49fa-a6f3-f850f4f824cd.jpg', description: 'Single queer mom helping raise a 10 year old boy in the Denver area.', zip_code: 80_220)
      post '/graphql', params: { query: query_two }
      json = JSON.parse(response.body)
      data = json['data']['users']
      expect(data).to eq([{ 'id' => "#{@user1.id}",
                            'userName' => 'Garnet',
                            'email' => 'garnet@universe.com',
                            'description' => 'We are a married lesbian couple with kids. We love to play sports and go on adventures!',
                            'image' => 'https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png',
                            'zipCode' => 80_220 },
                          { 'id' => "#{@user2.id}",
                            'userName' => 'Pearl',
                            'email' => 'pearl@universe.com',
                            'description' => 'I am a non-binary single parent looking for other enby parents.',
                            'image' => 'https://user-images.githubusercontent.com/99059063/187045202-04577eee-4d6b-4a6e-8d71-5b96aef2f6fc.png',
                            'zipCode' => 80_220 },
                          { 'id' => "#{@user3.id}",
                            'userName' => 'Amethyst',
                            'email' => 'amethyst@universe.com',
                            'description' => 'Single queer mom helping raise a 10 year old boy in the Denver area.',
                            'image' => 'https://user-images.githubusercontent.com/99059063/187045161-3338af1c-49c6-49fa-a6f3-f850f4f824cd.jpg',
                            'zipCode' => 80_220 }])
    end
  end

  def query
    <<~GQL
      { user(id: "#{@user.id}") {
         id
         userName
         email
         description
         image
         zipCode
       }
       }
    GQL
  end

  def query_two
    <<~GQL
      { users {
         id
         userName
         email
         description
         image
         zipCode
       }
       }
    GQL
  end
end
