require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:thumbnail_key) }
    it { is_expected.to validate_presence_of(:video_key) }

    describe 'episode_number' do
      subject { build(:movie, :episode, serie: serie, episode_number: 1) }

      let(:serie) { create(:serie) }

      let!(:old_episode) { create(:movie, :episode, serie: serie, episode_number: 1) }

      it { is_expected.to validate_presence_of(:episode_number) }

      it 'has error messages' do
        subject.valid?

        expect(subject.errors.full_messages).to include('Episode number has already been taken')
      end
    end

    describe 'category presence' do
      context 'when episode' do
        subject { build(:movie, :episode) }

        it { is_expected.not_to validate_presence_of(:category) }
      end

      context 'when normal movie' do
        subject { build(:movie) }

        it { is_expected.to validate_presence_of(:category) }
      end
    end

    describe 'highlight_episode' do
      context 'when episode' do
        subject { build(:movie, :episode, highlighted: true) }

        it 'invalidates the movie if it is an episode' do
          expect(subject.valid?).to be_falsy
        end

        it 'has error message' do
          subject.valid?

          expect(subject.errors.full_messages).to include(
            'It\'s not possible to highlight serie episode'
          )
        end
      end

      context 'when normal movie' do
        context 'when highlighted' do
          subject { build(:movie, highlighted: true) }

          it 'is valid' do
            expect(subject.valid?).to be_truthy
          end
        end

        context 'when not hightlighted' do
          subject { build(:movie, highlighted: false) }

          it 'is valid' do
            expect(subject.valid?).to be_truthy
          end
        end
      end
    end
  end

  describe 'associations' do
    subject { build(:movie) }

    it { is_expected.to belong_to(:serie).optional }

    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:players).dependent(:destroy) }

    it { is_expected.to have_one(:watched_serie).dependent(:nullify) }
  end
end
