require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:user) }
  end
end
