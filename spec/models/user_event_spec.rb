require 'rails_helper'

RSpec.describe UserEvent, type: :model do 
  it { should belong_to(:user) }
  it { should belong_to(:event) }
end