class Mutations::DeleteUserEvent < Mutations::BaseMutation
  argument :user_id, Integer, required: true
  argument :event_id, Integer, required: true

  type Types::UserEventType

  def resolve(user_id:, event_id:)
    UserEvent.find_by(user_id: user_id, event_id: event_id).delete
  end
end
