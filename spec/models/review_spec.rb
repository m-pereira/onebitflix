require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:rating) }
    it {
      is_expected.to validate_numericality_of(:rating)
        .only_integer
        .is_greater_than(0)
        .is_less_than_or_equal_to(5)
    }

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(50) }

    describe 'uniqueness scoped by user' do
      subject { new_revew.valid? }

      let(:new_revew) { build(:review, reviewable: movie, user: user) }

      let!(:movie) { create(:movie) }
      let!(:user) { create(:user) }
      let!(:first_review) { create(:review, reviewable: movie, user: user) }

      it { is_expected.to be_falsy }

      it 'has the error message' do
        subject

        expect(new_revew.errors.full_messages).to include(
          'User can add only one review per resource'
        )
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:reviewable) }
  end
end
