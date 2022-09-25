class Mutations::CreateTag < Mutations::BaseMutation
  argument :title, String, required: true

  field :tag, Types::TagType, null: false
  field :errors, [String], null: false

  def resolve(title:)
binding.pry
    tag = Tag.new(title: title)

    if tag.save
      {
        tag: tag,
        errors: []
      }
    else
      {
        tag: nil,
        errors: tag.errors.full_messages
      }
    end
  end
end