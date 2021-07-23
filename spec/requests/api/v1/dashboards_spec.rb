require 'rails_helper'

RSpec.describe 'Api::V1::Dashboards', type: :request do
  before { sign_in(user) }

  let(:user) { create(:user) }

  before do
    allow(LastSeenResourceFinder).to receive(:call).and_return([])
  end

  describe 'GET #index' do
    subject { get api_v1_dashboard_path, params: { type: type } }

    context 'when param type is nil' do
      let(:type) { nil }

      it 'has http_status ok' do
        subject

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when param is valid' do
      let(:type) { 'keep_watching' }
      let(:movie) { create(:movie) }
      let(:serie) { create(:serie) }
      let(:serialized_movie) { serialize(movie) }
      let(:serialized_serie) { serialize(serie) }

      it 'has http_status ok' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'calls LastSeenResourceFinder with the param' do
        allow(LastSeenResourceFinder).to receive(:call).with(type, user).and_return([])
        expect(LastSeenResourceFinder).to receive(:call).with(type, user).and_return([])

        subject
      end

      it 'returns serialized collection' do
        allow(LastSeenResourceFinder).to receive(:call).with(type, user).and_return([
          movie, serie
        ])

        subject

        expect(json).to eq([serialized_movie, serialized_serie])
      end
    end

    context 'when invalid type param' do
      let(:type) { 'abobrinha' }

      it 'has http_status forbidden' do
        subject

        expect(response).to have_http_status(:forbidden)
      end

      it 'has error message' do
        subject

        expect(json[:errors]).to include('Unpermitted type parameter')
      end
    end
  end
end
