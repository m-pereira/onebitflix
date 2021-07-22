require 'rails_helper'

RSpec.describe Serie, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:thumbnail_key) }

    describe 'highlightable concern' do
      context 'when same model' do
        subject { build(:serie, :highlighted) }

        let!(:old_highlighted) { create(:serie, :highlighted) }

        it 'is invalid because only one can be highlighted' do
          expect(subject.valid?).to be_falsy
        end

        it 'has the error message' do
          subject.valid?

          expect(subject.errors.full_messages).to include(
            'Only one highlighted entity is permitted'
          )
        end
      end

      context 'when other model' do
        subject { build(:serie, :highlighted) }

        let!(:old_highlighted) { create(:movie, :highlighted) }

        it 'is invalid because only one can be highlighted' do
          expect(subject.valid?).to be_falsy
        end

        it 'has the error message' do
          subject.valid?

          expect(subject.errors.full_messages).to include(
            'Only one highlighted entity is permitted'
          )
        end
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:last_watched_episode).optional }

    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:episodes).dependent(:destroy) }
  end
end
