require 'rails_helper'

RSpec.describe Mutations::CreateTag, type: :request do
  describe '.resolve' do
    it 'creates a tag', :vcr do
      expect(Tag.count).to eq(0)
      post '/graphql', params: { query: query }
      expect(Tag.count).to eq(1)
    end
  end

  def query
    <<~GQL
      mutation {
        createTag(input: {
          title: "Garnet"
       }) { tag {
          id
          title
        }
        }
      }
    GQL
  end
end