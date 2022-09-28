module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false
    
    field :tags, [Types::TagType], null: false

    def tags 
      Tag.all 
    end

    field :event, Types::EventType, null: false do 
      argument :id, Integer, required: true
    end

    def event(id:)
      Event.find(id)
    end


    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end
  end
end
