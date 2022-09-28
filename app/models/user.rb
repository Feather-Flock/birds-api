class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events
  has_many :user_tags
  has_many :tags, through: :user_tags 

  validates_presence_of :user_name
  validates_presence_of :email
  validates_presence_of :zip_code
  validates_presence_of :lat
  validates_presence_of :lng
end
