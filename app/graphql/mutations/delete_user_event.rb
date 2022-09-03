class Mutations::DeleteUserEvent < Mutations::BaseMutation
  argument :id, Integer, required: true

  type Types::UserEventType

  def resolve(id:)
    UserEvent.find(id).delete
  end
end
