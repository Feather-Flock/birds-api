require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:user_events) }
  it { should have_many(:events).through(:user_events) }
  it { should have_many(:user_tags) }
  it { should have_many(:tags).through(:user_tags) }

  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lng) }
end
