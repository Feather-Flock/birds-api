# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(user_name: "Garnet", email: "garnet@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png" , description: "We are a married lesbian couple with kids. We love to play sports and go on adventures!" , zip_code: 80220)
user2 = User.create(user_name: "Pearl", email: "pearl@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045202-04577eee-4d6b-4a6e-8d71-5b96aef2f6fc.png" , description: "I am a non-binary single parent looking for other enby parents.", zip_code: 80220)
user3 = User.create(user_name: "Amethyst", email: "amethyst@universe.com", image: "https://user-images.githubusercontent.com/99059063/187045161-3338af1c-49c6-49fa-a6f3-f850f4f824cd.jpg" , description: "Single queer mom helping raise a 10 year old boy in the Denver area.", zip_code: 80220)

event1 = user1.events.create(title: "Lunch at Denison Park", description: "We are getting together for a meet-and-greet at Denison Park.", time: '18:00:00', date: '2022-10-09', lat: "39.733", lng: "-104.904", address: "1105 Quebec St", city: "Denver", state: "CO", zip: 80220)
event2 = user2.events.create(title: "Games at Verbena", description: "Games at Verbena Park", time: '18:00:00', date: '2022-09-15', lat: "39.650", lng: "-104.893", address: "1151 Verbena St", city: "Denver", state: "CO", zip: 80220)
event3 = user3.events.create(title: "Birthday Party at Montclair", description: "We will be celebrating Steven's 11th birthday!", time: '18:00:00', date: '2022-10-20', lat: 39.735, lng: -104.908, address: "6820 E 12th Ave", city: "Denver", state: "CO", zip: 80220)