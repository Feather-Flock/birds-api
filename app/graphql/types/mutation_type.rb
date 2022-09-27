module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_event, mutation: Mutations::CreateEvent
    field :create_user_event, mutation: Mutations::CreateUserEvent
    field :update_event, mutation: Mutations::UpdateEvent
    field :destroy_event, mutation: Mutations::DestroyEvent
    field :delete_user_event, mutation: Mutations::DeleteUserEvent
    field :create_tag, mutation: Mutations::CreateTag
    field :update_user, mutation: Mutations::UpdateUser
  end
end
