require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'relationships' do
    it { should have_many(:user_tags) }
    it { should have_many(:users).through(:user_tags)}
  end 
end
