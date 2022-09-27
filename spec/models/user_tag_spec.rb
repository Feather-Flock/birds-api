require 'rails_helper'

RSpec.describe UserTag, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:tag) }
  end
end
