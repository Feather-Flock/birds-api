class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :time
  validates_presence_of :date
  validates_presence_of :lat
  validates_presence_of :lng
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :host
end
