require 'rails_helper'

RSpec.describe Types::TagType, type: :request do
  describe '.tags' do
    it 'returns all tags' do
      @user = User.create(user_name: 'Garnet', email: 'garnet@universe.com', image: 'https://image.png',
                          description: 'We are a married lesbian couple with kids. We love to play sports and go on adventures!', zip_code: 80220, lat: '39.73', lng: '-104.91')
      @user.tags.create(title: "Sports")
      @user.tags.create(title: "Adventure")
      @user.tags.create(title: "Lesbian")

      post '/graphql', params: { query: query }

      json = JSON.parse(response.body)
      data = json['data']['tags']

      expect(data).to include(
        {"title"=>"Sports"}, 
        {"title"=>"Adventure"}, 
        {"title"=>"Lesbian"}
        )
    end 
  end 

  def query 
     <<~GQL
      { tags {
        title
       }
      }
    GQL
  end
end