module Types
  class UserTagType < Types::BaseObject
    field :user_id, ID, null: false 
    field :tag_id, ID, null: false 
    field :id, ID, null: false
  end
end