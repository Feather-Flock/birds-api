class Mutations::DeleteUserEvent < Mutations::BaseMutation
  # argument :user_id, Integer, required: true
  # argument :event_id, Integer, required: true
  argument :id, Integer, required: true

  type Types::UserEventType

  def resolve(id:)
    #binding.pry
    UserEvent.find(id).delete
  end
end
