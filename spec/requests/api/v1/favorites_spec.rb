require 'rails_helper'

RSpec.describe 'Api::V1::Favorites', type: :request do
  before { sign_in(user) }

  let(:user) { create(:user) }

  describe 'GET #index' do
    subject { get api_v1_favorites_path }

    let(:favorites) { create_list(:favorite, 2, user: user) }

    it 'returns http ok' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'show the favorites serialized' do
      favorites
      subject

      expect(json).to eq(serialize_all(favorites))
    end
  end

  describe 'POST #create' do
    context 'when successfully' do
      subject do
        post api_v1_favorites_path, params: {
          favorite: {
            favoritable_id: movie.id,
            favoritable_type: movie.class.to_s
          }
        }
      end

      let(:movie) { create(:movie) }

      it 'creates a new favorite' do
        expect { subject }.to change(Favorite, :count).by(1)
      end

      it 'returns http_status created' do
        subject

        expect(response).to have_http_status(:created)
      end
    end

    context 'when failure' do
      subject do
        post api_v1_favorites_path, params: {
          favorite: {
            favoritable_id: nil,
            favoritable_type: movie.class.to_s
          }
        }
      end

      let(:movie) { create(:movie) }

      it 'creates a new favorite' do
        expect { subject }.not_to change(Favorite, :count)
      end

      it 'returns http_status created' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'has the error message' do
        subject

        expect(json.dig(:errors)).to include('Favoritable must exist')
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete api_v1_favorite_path(id: movie.id, type: movie.class.to_s) }

    let!(:movie) { create(:movie) }
    let!(:favorite) { create(:favorite, user: user, favoritable: movie) }

    it 'deletes the favorite' do
      expect { subject }.to change(Favorite, :count).by(-1)
    end

    it 'returns http_status ok' do
      subject

      expect(response).to have_http_status(:ok)
    end
  end
end
