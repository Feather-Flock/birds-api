module Types
  class TagType < Types::BaseObject
    field :title, String, null: false 
    field :id, ID, null: false

    # field :tags, [Types::TagType], null: false
 
    # def tags 
    #   Tag.all 
    # end
  end 
end