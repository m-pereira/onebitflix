require 'rails_helper'

RSpec.describe 'Api::V1::Review', type: :request do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #index' do
    subject { get api_v1_reviews_path }

    let(:reviews) { create_list(:review, 2, user: user) }

    it 'has http_status ok' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'has reviews serialized' do
      reviews
      subject

      expect(json).to eq(serialize_all(reviews))
    end
  end

  describe 'POST #create' do
    context 'when successfully' do
      subject do
        post api_v1_reviews_path, params: {
          review: {
            reviewable_id: movie.id,
            reviewable_type: movie.class.to_s,
            description: 'Some review description. Some review description. ' \
              'Some review description. Some review description',
            rating: 3
          }
        }
      end

      let(:movie) { create(:movie) }

      it 'creates a review' do
        expect { subject }.to change(Review, :count).by(1)
      end

      it 'has http_status created' do
        subject

        expect(response).to have_http_status(:created)
      end

      it 'returns the review created' do
        subject

        expect(json).to include(
          description: 'Some review description. Some review description. ' \
            'Some review description. Some review description'
        )
        expect(json).to include(rating: 3)
        expect(json).to include(reviewable_type: movie.class.to_s)
      end
    end

    context 'when failed' do
      subject do
        post api_v1_reviews_path, params: {
          review: {
            reviewable_id: movie.id,
            reviewable_type: movie.class.to_s,
            description: nil,
            rating: -1
          }
        }
      end

      let(:movie) { create(:movie) }

      it 'does not create a review' do
        expect { subject }.not_to change(Review, :count)
      end

      it 'has http_status unprocessable_entity' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the errors messages' do
        subject

        expect(json[:errors]).to include('Rating must be greater than 0')
        expect(json[:errors]).to include('Description can\'t be blank')
      end
    end
  end
end
