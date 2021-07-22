require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:favoritable) }
  end

  describe 'validations' do
    describe 'uniqueness of user' do
      subject { build(:favorite, user: user, favoritable: movie) }

      let!(:old_favorite) { create(:favorite, user: user, favoritable: movie) }

      let(:movie) { create(:movie) }
      let(:user) { create(:user) }

      it 'invalidates the new favorite' do
        expect(subject.valid?).to be_falsy
      end

      it 'has the erro message' do
        subject.valid?

        expect(subject.errors.full_messages).to include(
          'User can favorite only one time per resource'
        )
      end
    end
  end
end
