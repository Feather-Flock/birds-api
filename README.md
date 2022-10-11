# :flamingo: Birds of a Feather API :flamingo:
<!-- TABLE OF CONTENTS -->
  <details>
  <summary>Table of Contents</summary>
  <ol>
    </li>
    <li><a href="#flamingo-project-overview">Project Overview</a></li>
    <li><a href="#flamingo-built-with">Built With</a></li>
    <li><a href="#flamingo-schema">Schema</a></li>
    <li><a href="#flamingo-api-endpoints">API Endpoints</a></li>
    <li><a href="#flamingo-local-setup">Local Setup</a></li>
    <li><a href="#flamingo-contributors">Contributors</a></li>
  </ol>
</details>

<!-- PROJECT OVERVIEW -->
## :flamingo: Project Overview
:rainbow_flag: Birds of a Feather :rainbow_flag: is an app that connects LGBTQIA2S+ families to events in their community.  Users can search the app for gatherings in their immediate vicinity or specify a radius and RSVP to events that interest them.  Users can also create and host their own events and allow other users to RSVP. The back-end of this application utilizes a PostgreSQL relational database and Graphql to accomodate requests from the front-end and communicate via internal API.<br>
<br>:rainbow_flag: Visit the live app [here](http://www.birds-of-a-feather.net/)<br>
:rainbow_flag: Check out the front-end repo [here](https://github.com/Feather-Flock/birds-ui)

<!-- BUILT WITH -->
## :flamingo: Built With
[<img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white"/>](https://www.ruby-lang.org/en/) **Version 2.7.4**<br>
[<img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>](https://rubyonrails.org/) **Version 7.0.3.1**<br>
<img src="https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white"/><br>
<img src="https://img.shields.io/badge/GraphQl-E10098?style=for-the-badge&logo=graphql&logoColor=white"/><br>
<img src="https://img.shields.io/badge/circleci-343434?style=for-the-badge&logo=circleci&logoColor=white"/><br>
<img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white"/><br>
[<img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white"/>](https://www.postman.com/product/what-is-postman/)<br>

<!-- SCHEMA -->
## :flamingo: Schema
<img width="946" alt="Screen Shot 2022-10-11 at 11 29 02 AM" src="https://user-images.githubusercontent.com/98491210/195161912-01b7ea52-16c4-4542-af26-dc0a32e09ff0.png">


<!-- API ENDPOINTS -->
## :flamingo: API Endpoints
The following endpoints are exposed, and all endpoints begin with this base URL: `https://birds-api.herokuapp.com/` , and all Graphql endpoints respond to `POST /graphql` requests only.  Query information will need to be sent in the body of the request.<br>
### User
:peacock: Create User
```ruby
createUser(input: {
          userName:
          email:
          image:
          description:
          zipCode:
         })
```
Example response:
```ruby
{
    "data": {
        "user": {
            "id": "1",
            "userName": "Garnet",
            "email": "garnet@universe.com",
            "description": "We are a married lesbian couple with kids. We love to play sports and go on adventures!",
            "image": "https://user-images.githubusercontent.com/99059063/187045147-667959c8-70f2-4fb3-b089-ca81f23a0310.png",
            "zipCode": 80220
        }
...
```
### Event
:peacock: Create Event
```ruby
createEvent(input: {
          title:
          description:
          time: # "00:00:00"
          date: # "YYYY-MM-DD"
          address:
          city:
          state:
          zip:
          host: #id of user creating event
       })
```
Example response:
```ruby
{
    "data": {
        "createEvent": {
            "event": {
                "title": "Park hangout",
                "description": "Single dad hanging with 7 year old son and friends at park",
                "time": "12:00:00",
                "date": "2022-09-23",
                "address": "2455 Bryant Street",
                "city": "Denver",
                "state": "CO",
                "zip": 80211,
                "lat": 39.753163,
                "lng": -105.019169,
                "host": 1
            }
...
```
:peacock: Update Event<br>
You will need to include in your request the event and ID and ONLY the attributes of the event you wish to update.  The response will include all of the event information including the updated attributes, as well as the number of rsvps the event currenly has.
```ruby
updateEvent(input: {
          id:
          #attributes to be updated
       })
```
Example response
```ruby
{
    "data": {
        "createEvent": {
            "event": {
                "title": "Park hangout",
                "description": "Single dad hanging with 7 year old son and friends at park",
                "time": "16:30:00",
                "date": "2022-09-23",
                "address": "2455 Bryant Street",
                "city": "Denver",
                "state": "CO",
                "zip": 80211,
                "lat": 39.753163,
                "lng": -105.019169,
                "host": 1,
                "rsvps": 3
            }
...
```
:peacock: Delete Event
```ruby
destroyEvent(input: {
          id: 2
       })
```
Example Response<br>
This endpoint will return all of the destroyed event's information, but if you try to run the same request for an event that has already been destroyed you will get an error as that event's id will not be found.
```ruby
{
    "data": {
        "destroyEvent": {
            "event": {
                "title": "Park hangout",
                "description": "Single dad hanging with 7 year old son and friends at park",
                "time": "12:00:00",
                "date": "2022-09-23",
                "address": "2455 Bryant Street",
                "city": "Denver",
                "state": "CO",
                "zip": 80211,
                "lat": 39.753163,
                "lng": -105.019169,
                "host": 1,
                "rsvps": 3
            }
...
```
### User Event (RSVP)
:peacock: Create User Event
```ruby
createUserEvent(input: {
          userId:
          eventId:
       })
```
Example Response
```ruby
{
    "data": {
        "createUserEvent": {
            "userEvent": {
                "userId": 1,
                "eventId": 1,
                "id": "5",
                "createdAt": "2022-09-01T02:26:29Z"
            }
...
```
:peacock: Delete User Event<br>
This endpoint takes the user id and the event id, but does NOT take the userEvent id.
```ruby
 deleteUserEvent(input: {
          userId: 1,
          eventId: 1
       })
```
Example Response
```ruby
{
    "data": {
        "deleteUserEvent": {
              "userId": 1,
               "eventId": 1,
               "id": "5",
               "createdAt": "2022-09-01T02:26:29Z"
            }
...
```
### Other Endpoints
:peacock: User Events<br>
This endpoint returns an array of all of the events created by a user.
```ruby
user(id: "1") {
     userEvents(id: "1") {
          id
          title
          description
          zip
          lat
          lng
          date
          time
          host
       }      
```
Example Response
```ruby
{
    "data": {
        "user": {
            "userEvents": [
                {
                    "id": "1",
                    "title": "Lunch at Denison Park",
                    "description": "We are getting together for a meet-and-greet at Denison Park.",
                    "zip": 80220,
                    "lat": 39.733,
                    "lng": -104.904,
                    "date": "2022-10-09",
                    "time": "18:00:00",
                    "host": 1
                }
            ]
...
```
:peacock: User Rsvp'd Events<br>
This endpoint will return an array of all the events a user has rsvp'd to (i.e. the user is not the host of any of these events).
```ruby
user(id: "1") {
    rsvpdEvents(id: "1") {
          id
          title
          description
          zip
          lat
          lng
          date
          time
          host
       }
```
Example Response
```ruby
{
    "data": {
        "user": {
            "rsvpdEvents": [
                {
                    "id": "1",
                    "title": "Lunch at Denison Park",
                    "description": "We are getting together for a meet-and-greet at Denison Park.",
                    "zip": 80220,
                    "lat": 39.733,
                    "lng": -104.904,
                    "date": "2022-10-09",
                    "time": "18:00:00",
                    "host": 2
                }
            ]
...
```
:peacock: User Near Events<br>
This endpoint returns an array of events happening in the same zipcode as the user's location.
```ruby
user(id: "1") {
    nearEvents(id: "1") {
        id
        title
        description
        zip
        lat
        lng
        date
        time
        host
      }
```
Example Response
```ruby
{
    "data": {
        "user": {
            "nearEvents": [
                {
                    "id": "1",
                    "title": "Lunch at Denison Park",
                    "description": "We are getting together for a meet-and-greet at Denison Park.",
                    "zip": 80220,
                    "lat": 39.733,
                    "lng": -104.904,
                    "date": "2022-10-09",
                    "time": "18:00:00",
                    "host": 1
                },
                {
                    "id": "2",
                    "title": "Games at Verbena",
                    "description": "Games at Verbena Park",
                    "zip": 80220,
                    "lat": 39.65,
                    "lng": -104.893,
                    "date": "2022-09-15",
                    "time": "18:00:00",
                    "host": 2
                },
                {
                    "id": "3",
                    "title": "Birthday Party at Montclair",
                    "description": "We will be celebrating Steven's 11th birthday!",
                    "zip": 80220,
                    "lat": 39.735,
                    "lng": -104.908,
                    "date": "2022-10-20",
                    "time": "18:00:00",
                    "host": 3
                }
            ]
...
```
<!-- LOCAL SETUP -->
## :flamingo: Local Setup
1. Check your versions of both Ruby(2.7.4 or later) and Rails(7.0.3.1 or later) by running the following in your command line:
  `ruby -v` then `rails -v`
2. Fork and clone the repo to your local machine with SSH: `git clone git@github.com:Feather-Flock/birds-api.git`
3. Register for external API keys:
  * [Mapquest API key](https://developer.mapquest.com/user/login/sign-up)
  * [Zipcode API key](http://www.zipcodeapi.com/Register)
4. Install gems and dependencies: `bundle install`
5. Configure API keys by running `bundle exec figaro install` and then adding keys to `application.yml` file:
```ruby
mapquest_api_key: your_key_here
zipcode_api_key: your_key_here
```
6. Set up database: `rails db:{drop,create,migrate,seed}`
7. Run test suite: `bundle exec rspec`
8. Start up your local server: `rails s`
6. Visit the endpoint url `http://localhost:3000/graphql` to consume the API locally.


<!-- CONTRIBUTORS -->
## :flamingo: Contributors
### Back-End Team
* Clay Ash (she/they) • [Github](https://github.com/clayAsh) • [LinkedIn](https://www.linkedin.com/in/clay-ash-b4422b188/)
* Deannah Burke (she/her) • [Github](https://github.com/deannahburke) • [LinkedIn](https://www.linkedin.com/in/deannah-burke/)
* Luke Pascale (he/him) • [Github](https://github.com/enalihai) • [LinkedIn](https://www.linkedin.com/in/luke-pascale)
* Ian Ross (he/him) • [Github](https://github.com/ross-ian28) • [LinkedIn](https://www.linkedin.com/in/ross-ian28/)

### Front-End Team
* Amber Bodnar (she/her) • [Github](https://github.com/abodnar1) • [LinkedIn](https://www.linkedin.com/in/amberbodnar/)
* Trish Fox-Collis (she/her) • [Github](https://github.com/tfoxcollis) • [LinkedIn](https://www.linkedin.com/in/trish-fox-collis/)
* Blue Nealis (they/them) • [Github](https://github.com/BlueNealis) • [LinkedIn](https://www.linkedin.com/in/blue-nealis/)
