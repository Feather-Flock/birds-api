require 'rails_helper'

RSpec.describe Event, type: :model do 
  it { should have_many(:user_events) }
  it { should have_many(:users).through(:user_events) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lng) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:host) }
end