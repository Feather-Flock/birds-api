class Mutations::CreateUserTag < Mutations::BaseMutation
  argument :user_id, Integer, required: true
  argument :tag_id, Integer, required: true

  field :user_tag, Types::UserTagType, null: false
  field :errors, [String], null: false

  def resolve(user_id:, tag_id:)
    ut = UserTag.new(user_id: user_id, tag_id: tag_id)
    if ut.save
      {
        user_tag: ut,
        errors: []
      }
    else
      {
        user_tag: nil,
        errors: ut.errors.full_messages
      }
    end
  end
end