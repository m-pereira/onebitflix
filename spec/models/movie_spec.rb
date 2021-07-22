require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:serie) }
  end
end
