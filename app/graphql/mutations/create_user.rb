class Mutations::CreateUser < Mutations::BaseMutation
  argument :user_name, String, required: true
  argument :email, String, required: true
  argument :description, String, required: false
  argument :image, String, required: false
  argument :zip_code, Integer, required: true

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(user_name:, email:, description:, image:, zip_code:)
    cords = MapFacade.create_cords(zip_code)
    user = User.new(user_name: user_name, email: email, description: description, image: image, zip_code: zip_code, lat: cords[:lat], lng: cords[:lng])
    if user.save
      {
        user: user,
        errors: []
      }
    else
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end
