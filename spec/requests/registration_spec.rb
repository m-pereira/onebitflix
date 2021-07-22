require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  describe 'POST #create' do
    subject do
      post user_registration_path, params: {
        user: {
          name: 'New Name',
          email: 'new@email.com',
          password: '123456'
        }
      }
    end

    it 'creates a new user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'redirects to root' do
      subject

      expect(response).to redirect_to(root_path)
    end
  end
end
