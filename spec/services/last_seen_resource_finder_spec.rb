require 'rails_helper'

RSpec.describe LastSeenResourceFinder, type: :service do
  describe '.call' do
    subject { described_class.call(param1, param2) }

    let(:param1) { 'category' }
    let(:param2) { create(:user) }
    let(:instance) { double(described_class) }

    it 'instanciate the class' do
      allow(described_class).to receive(:new).with(param1, param2).and_return(instance)
      allow(instance).to receive(:call)
      expect(instance).to receive(:call)

      subject
    end
  end

  describe '#call' do
    context 'when type is category' do
      subject { described_class.call('category', user) }

      let!(:category) { create(:category) }
      let(:user) { create(:user) }

      it {
        is_expected.to eq(
          [
            {
              id: category.id,
              movies: [],
              name: category.name,
              series: []
            }
          ]
        )
      }
    end

    context 'when type is keep_watching' do
      subject { described_class.call('keep_watching', user) }

      let!(:player) { create(:player, user: user, end_date: nil, movie: movie) }
      let(:movie) { create(:movie) }
      let(:user) { create(:user) }

      it {
        is_expected.to eq(
          [
            {
              id: player.id,
              elapsed_time: player.elapsed_time.strftime('%H:%M:%S'),
              end_date: nil,
              start_date: time_formatter(player.start_date, format: :default),
              movie: {
                description: movie.description,
                episode_number: movie.episode_number,
                featured_thumbnail_key: movie.featured_thumbnail_key,
                highlighted: movie.highlighted,
                id: movie.id,
                thumbnail_cover_key: movie.thumbnail_cover_key,
                thumbnail_key: movie.thumbnail_key,
                title: movie.title,
                video_key: movie.video_key
              }
            }
          ]
        )
      }
    end

    context 'when type is highlight' do
      subject { described_class.call('highlight', user) }

      let!(:movie) { create(:movie, :highlighted) }
      let(:user) { create(:user) }

      it {
        is_expected.to eq(
          [
            {
              id: movie.id,
              title: movie.title,
              description: movie.description,
              thumbnail_key: movie.thumbnail_key,
              video_key: movie.video_key,
              episode_number: nil,
              featured_thumbnail_key: movie.featured_thumbnail_key,
              highlighted: true,
              serie: nil,
              thumbnail_cover_key: movie.thumbnail_cover_key,
              category: {
                id: movie.category.id,
                name: movie.category.name
              }
            }
          ]
        )
      }
    end
  end
end
