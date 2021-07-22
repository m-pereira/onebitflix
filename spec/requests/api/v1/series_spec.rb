require 'rails_helper'

RSpec.describe 'Api::V1::Series', type: :request do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #show' do
    subject { get api_v1_serie_path(serie) }

    let(:serie) { create(:serie) }

    it 'has http_status ok' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'returns the serie serialized' do
      subject

      expect(json).to eq(serialize(serie))
    end
  end
end
