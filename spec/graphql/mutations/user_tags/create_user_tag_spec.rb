require 'rails_helper'

RSpec.describe Mutations::CreateUserTag, type: :request do
  describe '.resolve' do
    it 'creates a user tag', :vcr do
      @tag = Tag.create(title: "Sports")
      @user = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220, lat: '39.73', lng: '-104.91')

      expect(UserTag.count).to eq(0)

      post '/graphql', params: { query: query(user_id: @user.id, tag_id: @tag.id) }

      expect(UserTag.count).to eq(1)

      json = JSON.parse(response.body)
      data = json['data']['createUserTag']
      expect(data['userTag']).to include(
        'userId' => @user.id.to_s,
        'tagId' => @tag.id.to_s
      )
    end
  end 

  describe 'sad path' do
    it 'returns error message for request with no id', :vcr do
      @tag = Tag.create(title: "Sports")

      expect(UserTag.count).to eq(0)

      post '/graphql', params: { query: sad_query(user_id: nil, tag_id: @tag.id) }

      expect(UserTag.count).to eq(0)

      json = JSON.parse(response.body)

      expect(json["errors"][0]).to include(
        "message"=>"Argument 'userId' on InputObject 'CreateUserTagInput' has an invalid value (nil). Expected type 'Int!'."
      )
    end
  end 

  def query(user_id:, tag_id:)
    <<~GQL
      mutation {
        createUserTag(input: {
          userId: #{@user.id},
          tagId: #{@tag.id}
       }) { userTag {
          userId
          tagId
          id
          }
        }
      }
    GQL
  end

  def sad_query(user_id:, tag_id:)
    <<~GQL
      mutation {
        createUserTag(input: {
          userId: nil,
          tagId: #{@tag.id}
       }) { userTag {
          userId
          tagId
          id
          }
        }
      }
    GQL
  end
end 