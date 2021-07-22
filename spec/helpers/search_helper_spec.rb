require 'rails_helper'

RSpec.describe SearchHelper, type: :helper do
  describe '#serialize_collection' do
    subject { helper.serialize_collection(collection) }

    let(:collection) { [movie, serie] }
    let(:movie) { create(:movie) }
    let(:serie) { create(:serie) }

    it 'returns an array with all instances serialized' do
      serialized_movie = serialize(movie)
      serialized_serie = serialize(serie)

      expect(subject).to eq(
        [serialized_movie, serialized_serie]
      )
    end
  end
end
