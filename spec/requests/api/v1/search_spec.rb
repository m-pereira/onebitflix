require 'rails_helper'

RSpec.describe 'Api::V1::Searchs', type: :request do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #search' do
    let(:movie) { create(:movie, title: 'Some test') }
    let(:serie) { create(:serie, title: 'Another test') }

    context 'when param is valid' do
      subject { get api_v1_searchs_path, params: { value: 'test' } }

      it 'returns the collection serialized' do
        serialized_movie = serialize(movie)
        serialized_serie = serialize(serie)

        subject

        expect(json).to include(serialized_movie)
        expect(json).to include(serialized_serie)
      end

      it 'returns http_status ok' do
        subject

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when param invalid' do
      subject { get api_v1_searchs_path, params: { value: '' } }

      it 'returns http_status unprocessable_entity' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        subject

        expect(json[:errors]).to include('Parameter :value must have at least 3 characters')
      end
    end
  end
end
