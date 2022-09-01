class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events
  validates_presence_of :user_name
  validates_presence_of :email
  validates_presence_of :zip_code
end
