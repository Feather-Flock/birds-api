class Mutations::UpdateUser < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :user_name, String, required: false
  argument :email, String, required: false
  argument :description, String, required: false
  argument :image, String, required: false
  argument :zip_code, Integer, required: false
  argument :lat, Float, required: false  
  argument :lng, Float, required: false  

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(id:, **attributes)
    user = User.find(id)
    if user.update(attributes)
      { user: user }
    else
      { errors: user.errors.full_messages }
    end
  end
end