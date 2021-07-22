require 'rails_helper'

RSpec.describe Serie, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:thumbnail_key) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:last_watched_episode).optional }

    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:episodes) }
  end
end
