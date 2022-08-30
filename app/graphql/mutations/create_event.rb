class Mutations::CreateEvent < Mutations::BaseMutation
  argument :title, String, required: true 
  argument :description, String, required: true
  argument :time, String, required: true 
  argument :date 
  argument :lat
  argument :lng
  argument :address, String, required: true
  argument :city, String, required: true 
  argument :state, String, required: true 
  argument :zip
end