user1 = User.create(user_name: 'Garnet', email: 'garnet@universe.com',
                    image: 'https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png', description: 'We are a married lesbian couple with kids. We love to play sports and go on adventures!', zip_code: 80220, lat: '39.73', lng: '-104.91')
user2 = User.create(user_name: 'Pearl', email: 'pearl@universe.com',
                    image: 'https://user-images.githubusercontent.com/99059063/187045202-04577eee-4d6b-4a6e-8d71-5b96aef2f6fc.png', description: 'I am a non-binary single parent looking for other enby parents.', zip_code: 80220, lat: '39.73', lng: '-104.91')
user3 = User.create(user_name: 'Amethyst', email: 'amethyst@universe.com',
                    image: 'https://user-images.githubusercontent.com/99059063/187045161-3338af1c-49c6-49fa-a6f3-f850f4f824cd.jpg', description: 'Single queer mom helping raise a 10 year old boy in the Denver area.', zip_code: 80220, lat: '39.73', lng: '-104.91')
user5 = User.create(user_name: 'Velma', email: 'velma@scooby.com',
                    image: 'https://static.wikia.nocookie.net/scoobydoo/images/9/9d/Velma_Dinkley.png/revision/latest?cb=20201229021337', description: 'Single non-binary mom with 4 y/o twins, look forward to events!', zip_code: 80021, lat: '39.91', lng: '-105.12')
user6 = User.create(user_name: 'Smithers', email: 'smithers@simpsons.com',
                    image: 'https://static.wikia.nocookie.net/simpsons/images/2/20/Smithersdolls.jpg/revision/latest/scale-to-width-down/640?cb=20191031042110', description: 'Single father of 1, looking to meet other LGBT+ families.', zip_code: 80041, lat: '39.73', lng: '-105.17')
                    
event1 = user1.events.create(title: 'Lunch at Denison Park',
                             description: 'We are getting together for a meet-and-greet at Denison Park.', time: '18:00:00', date: '2022-10-09', lat: '39.733', lng: '-104.904', address: '1105 Quebec St', city: 'Denver', state: 'CO', zip: 80220, host: user1.id, slug: "/us/colorado/denver/80220/1105-quebec-st-39.733024,-104.903460")

event2 = user2.events.create(title: 'Games at Verbena', description: 'Games at Verbena Park', time: '18:00:00',
                             date: '2022-09-15', lat: '39.650', lng: '-104.893', address: '1151 Verbena St', city: 'Denver', state: 'CO', zip: 80220, host: user2.id, slug: "/us/colorado/denver/80220/1151-verbena-st-39.734947,-104.890586")
event3 = user3.events.create(title: 'Birthday Party at Montclair',
                             description: "We will be celebrating Steven's 11th birthday!", time: '18:00:00', date: '2022-10-20', lat: '39.735', lng: '-104.908', address: '6820 E 12th Ave', city: 'Denver', state: 'CO', zip: 80220, host: user3.id)
event4 = user5.events.create(title: 'Animal Antics at City Park',
                             description: 'Bring your animals, with or without fur, for a fun time at the park.', time: '12:00:00', date: '2022-10-11', lat: '39.745', lng: '-104.957', address: '2500 E 23rd Ave', city: 'Denver', state: 'CO', zip: 80205, host: user5.id)
event5 = user5.events.create(title: 'Zoo Trip', description: 'Lets see the animals!', time: '15:00:00',
                             date: '2022-09-14', lat: '39.751', lng: '-104.949', address: '3200 E 23rd Ave', city: 'Denver', state: 'CO', zip: 80205, host: user5.id)
event6 = user6.events.create(title: 'Birthday for Billy',
                             description: "We will be celebrating Billy's 8th birthday!", time: '13:00:00', date: '2022-10-13', lat: '39.739', lng: '-104.989', address: '101 14th Ave', city: 'Denver', state: 'CO', zip: 80204, host: user6.id)
event7 = user1.events.create(title: 'Sports and Exercise',
                             description: 'The best child is a tired child :) Bring your favorite outdoor game!', time: '10:00:00', date: '2022-10-09', lat: '39.688', lng: '-105.004', address: '1380 W Florida Ave', city: 'Denver', state: 'CO', zip: 80223, host: user1.id)
event8 = user2.events.create(title: 'Bike Riding Lessons', description: 'Trying to teach riding in a safe spot, come join!', time: '10:00:00',
                             date: '2022-09-17', lat: '39.650', lng: '-104.893', address: '1700 N Sheridan Blvd', city: 'Denver', state: 'CO', zip: 80212, host: user2.id)
event9 = user3.events.create(title: 'Bird Watching',
                             description: "We will be walking around trying to spot all the winged ones!", time: '15:00:00', date: '2022-10-18', lat: '39.712', lng: '-105.165', address: 'N Access Trail', city: 'Golden', state: 'CO', zip: 80401, host: user3.id)
event10 = user5.events.create(title: 'Saturday Sports Watch Party',
                             description: 'We are meeting at Sloans Lake to walk around then have lunch nearby.', time: '10:00:00', date: '2022-10-17', lat: '39.752', lng: '-105.053', address: '2501 Sheridan Boulevard', city: 'Edgewater', state: 'CO', zip: 80214, host: user5.id)
event11 = user5.events.create(title: 'Farmers Market Picnic', description: 'Buying a fun spread at the store then walking to the local park!', time: '12:00:00',
                             date: '2022-09-19', lat: '39.762', lng: '-105.058', address: '5508 W 32nd Ave', city: 'Wheat Ridge', state: 'CO', zip: 80214, host: user5.id)
event12 = user6.events.create(title: 'Go fly a kite!',
                             description: "Flying some kites for a few hours, come say hi even if you dont have one!", time: '14:00:00', date: '2022-10-17', lat: '39.780', lng: '-105.047', address: '4601 W 46th Ave', city: 'Denver', state: 'CO', zip: 80212, host: user6.id)
=======
                             description: "We will be celebrating Steven's 11th birthday!", time: '18:00:00', date: '2022-10-20', lat: '39.735', lng: '-104.908', address: '6820 E 12th Ave', city: 'Denver', state: 'CO', zip: 80220, host: user3.id, slug:  "/us/colorado/denver/80220-2905/6820-e-12th-ave-39.735623,-104.909402")

