require 'rails_helper'

RSpec.describe 'Api::V1::Movies', type: :request do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #show' do
    subject { get api_v1_movie_path(movie) }

    let(:movie) { create(:movie) }

    it 'has http_status ok' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'has the movie serialzied' do
      subject

      expect(json).to eq(serialize(movie))
    end
  end
end
