require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }

    before { sign_in(user) }

    it 'returns http ok' do
      get root_path

      expect(response).to have_http_status(:ok)
    end
  end
end
